class_name DelayedSelfAppBootstrap
extends Node

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")

const MEMORY_ONLY: String = "MEMORY_ONLY"
const PRODUCTION_READ_ONLY: String = "PRODUCTION_READ_ONLY"
const PRODUCTION_WRITE_ON_INTENT: String = "PRODUCTION_WRITE_ON_INTENT"
const BOOT_POLICIES: Array[String] = [
	MEMORY_ONLY,
	PRODUCTION_READ_ONLY,
	PRODUCTION_WRITE_ON_INTENT,
]

var _selected_policy: String = MEMORY_ONLY
var _policy_configured: bool = false
var _composition_started: bool = false
var _composition_status: String = "NOT_STARTED"
var _effective_policy: String = MEMORY_ONLY


func _ready() -> void:
	_compose_once(OS.get_cmdline_user_args())


func configure_boot_policy(policy: String) -> Dictionary:
	if is_inside_tree() or _composition_started:
		return _configuration_result(false, "BOOTSTRAP_CONFIGURATION_TOO_LATE")
	if _policy_configured:
		return _configuration_result(false, "BOOTSTRAP_ALREADY_CONFIGURED")
	if not BOOT_POLICIES.has(policy):
		return _configuration_result(false, "BOOTSTRAP_POLICY_REJECTED")
	_selected_policy = policy
	_policy_configured = true
	return _configuration_result(true, "BOOTSTRAP_POLICY_CONFIGURED")


func preview_effective_policy(arguments: PackedStringArray) -> Dictionary:
	var request: Dictionary = RouteRequest.parse_user_args(arguments)
	var effective: String = _selected_policy
	if not bool(request.get("ok", false)) or str(request.get("status", "")) == "DIRECT_LEVEL_REQUEST":
		effective = MEMORY_ONLY
	return {
		"status": "BOOTSTRAP_POLICY_PREVIEW",
		"effective_policy": effective,
		"request_status": str(request.get("status", "DIRECT_LEVEL_REQUEST_INVALID")),
	}


func get_composition_snapshot() -> Dictionary:
	return {
		"status": _composition_status,
		"configured": _policy_configured,
		"selected_policy": _selected_policy,
		"effective_policy": _effective_policy,
	}


func _compose_once(arguments: PackedStringArray) -> void:
	if _composition_started:
		return
	_composition_started = true
	var preview: Dictionary = preview_effective_policy(arguments)
	_effective_policy = str(preview.get("effective_policy", MEMORY_ONLY))
	var app_root: Node = AppRootScene.instantiate()
	if _effective_policy != MEMORY_ONLY:
		var access_policy: String = (
			LocalProfile.ACCESS_READ_ONLY
			if _effective_policy == PRODUCTION_READ_ONLY
			else LocalProfile.ACCESS_WRITE_ON_INTENT
		)
		var configured: Dictionary = app_root.configure_production_profile(access_policy)
		if not bool(configured.get("ok", false)):
			app_root.free()
			_composition_status = "CONFIGURATION_FAILED"
			return
	add_child(app_root)
	_composition_status = "APP_ROOT_ADDED"


func _configuration_result(ok: bool, status: String) -> Dictionary:
	return {
		"ok": ok,
		"status": status,
		"configured": _policy_configured,
		"policy": _selected_policy,
	}
