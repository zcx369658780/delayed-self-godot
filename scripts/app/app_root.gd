class_name DelayedSelfAppRoot
extends Node

const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const MemoryProgress = preload("res://scripts/app/memory_progress.gd")
const ProfileProgressAdapter = preload("res://scripts/app/profile_progress_adapter.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
const WindowPresentation = preload("res://scripts/app/window_presentation.gd")
const MainMenuScene = preload("res://scenes/ui/main_menu.tscn")
const LevelSelectScene = preload("res://scenes/ui/level_select.tscn")
const SafeErrorScene = preload("res://scenes/ui/safe_error.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const ROUTE_BOOT := "BOOT"
const ROUTE_MAIN_MENU := "MAIN_MENU"
const ROUTE_LEVEL_SELECT := "LEVEL_SELECT"
const ROUTE_GAMEPLAY := "GAMEPLAY"
const ROUTE_SAFE_ERROR := "SAFE_ERROR"
const ROUTES := [ROUTE_BOOT, ROUTE_MAIN_MENU, ROUTE_LEVEL_SELECT, ROUTE_GAMEPLAY, ROUTE_SAFE_ERROR]
const PROFILE_LOAD_ACCEPTED_STATUSES := ["MISSING_CLEAN", "LOADED", "SANITIZED", "RECOVERED_CLEAN"]
const PROFILE_PERSIST_ACCEPTED_STATUSES := ["PERSISTED", "NO_CHANGE"]
const PROFILE_FAILURE_SEAM_STAGES := ["NONE", "RECOVERY_COPY", "TEMP_WRITE", "TEMP_READBACK", "REPLACE", "POST_REPLACE_VERIFY"]

@export var catalog_path: String = "res://data/catalog/level_catalog_v1.json"

var _catalog: Dictionary = {}
var _progress: RefCounted
var _current_route: String = ROUTE_BOOT
var _active_screen: Node
var _gameplay_completion_handled: bool = false
var _boot_started: bool = false
var _test_profile_configured: bool = false
var _test_profile_path: String = ""
var _profile_adapter: RefCounted
var _profile_store: RefCounted
var _profile_boot_status: String = "NOT_STARTED"
var _profile_load_status: String = "NOT_STARTED"
var _profile_persist_status: String = "NOT_STARTED"

@onready var route_host: Control = $RouteHost


func _ready() -> void:
	RenderingServer.set_default_clear_color(WindowPresentation.BAR_COLOR)
	boot_with_user_args(OS.get_cmdline_user_args())


func configure_test_profile(canonical_test_profile_path: String) -> Dictionary:
	if is_inside_tree() or _boot_started:
		return _profile_configuration_rejected("APP_PROFILE_CONFIGURATION_TOO_LATE")
	if _test_profile_configured:
		return _profile_configuration_rejected("APP_PROFILE_ALREADY_CONFIGURED")
	var validation: Dictionary = LocalProfile.validate_test_profile_path(canonical_test_profile_path)
	if not bool(validation.get("ok", false)):
		return _profile_configuration_rejected(str(validation.get("status", "TEST_PROFILE_PATH_REJECTED")))
	_test_profile_path = str(validation.get("path", ""))
	_test_profile_configured = true
	return {
		"ok": true,
		"status": "APP_TEST_PROFILE_CONFIGURED",
		"configured": true,
		"mode": "TEST_PROFILE",
	}


func boot_with_user_args(arguments: PackedStringArray) -> void:
	_boot_started = true
	_current_route = ROUTE_BOOT
	var loaded: Dictionary = CatalogLoader.new().load_file(catalog_path)
	if not bool(loaded.get("ok", false)):
		var errors: Array = loaded.get("errors", [])
		var first: Dictionary = errors[0] if not errors.is_empty() and errors[0] is Dictionary else {"code": "CATALOG_INVALID", "message": "Catalog validation failed"}
		_show_safe_error(str(first.get("code", "CATALOG_INVALID")), str(first.get("message", "Catalog validation failed")))
		return
	_catalog = (loaded.get("catalog", {}) as Dictionary).duplicate(true)
	if _test_profile_configured:
		if not _boot_configured_test_profile():
			return
	else:
		_progress = MemoryProgress.new(_catalog)
		_profile_boot_status = "MEMORY_ONLY_READY"
	var request: Dictionary = RouteRequest.parse_user_args(arguments)
	if not bool(request.get("ok", false)):
		_show_safe_error(str(request.get("status", "DIRECT_LEVEL_REQUEST_INVALID")), "Invalid development direct-level request")
	elif str(request.get("status", "")) == "DIRECT_LEVEL_REQUEST":
		_route_level_id(str(request.get("level_id", "")), true)
	else:
		navigate(ROUTE_MAIN_MENU)


func _boot_configured_test_profile() -> bool:
	var adapter: RefCounted = ProfileProgressAdapter.new()
	var adapter_configuration: Dictionary = adapter.configure(_catalog)
	if not bool(adapter_configuration.get("ok", false)):
		return _configured_boot_failed(str(adapter_configuration.get("status", "ADAPTER_CONFIGURATION_FAILED")))
	var catalog_facts: Dictionary = (adapter_configuration.get("catalog_facts", {}) as Dictionary).duplicate(true)
	var store: RefCounted = LocalProfile.new()
	var store_configuration: Dictionary = store.configure_test(catalog_facts, _test_profile_path)
	if not bool(store_configuration.get("ok", false)):
		return _configured_boot_failed(str(store_configuration.get("status", "STORE_CONFIGURATION_FAILED")))
	_profile_store = store
	var load_result: Dictionary = store.load_profile()
	_profile_load_status = str(load_result.get("status", "LOAD_FAILED"))
	if not bool(load_result.get("ok", false)) or not PROFILE_LOAD_ACCEPTED_STATUSES.has(_profile_load_status):
		return _configured_boot_failed(_profile_load_status)
	var loaded_profile: Dictionary = (load_result.get("profile", {}) as Dictionary).duplicate(true)
	var hydration_result: Dictionary = adapter.load_profile(loaded_profile)
	if not bool(hydration_result.get("ok", false)):
		return _configured_boot_failed(str(hydration_result.get("status", "PROFILE_HYDRATION_FAILED")))
	_profile_adapter = adapter
	_progress = adapter
	_profile_boot_status = "TEST_PROFILE_READY"
	return true


func _configured_boot_failed(status: String) -> bool:
	_profile_boot_status = "FAILED_" + status.left(64)
	_show_safe_error("APP_TEST_PROFILE_BOOT_FAILED", "Test Profile session could not be initialized (" + status.left(64) + ")")
	return false


func navigate(route_id: String, payload: Dictionary = {}) -> void:
	if not ROUTES.has(route_id) or route_id == ROUTE_BOOT:
		_show_safe_error("APP_UNKNOWN_ROUTE", "Unknown route request: " + route_id.left(80))
		return
	match route_id:
		ROUTE_MAIN_MENU:
			_show_main_menu()
		ROUTE_LEVEL_SELECT:
			if _catalog.is_empty() or _progress == null:
				_show_safe_error("APP_NOT_BOOTSTRAPPED", "Level Select requires a validated catalog")
			else:
				_show_level_select()
		ROUTE_GAMEPLAY:
			if not payload.has("level_id"):
				_show_safe_error("APP_INVALID_GAMEPLAY_PAYLOAD", "Gameplay payload requires a catalog level_id")
			else:
				_route_level_id(payload.level_id, bool(payload.get("development_direct", false)))
		ROUTE_SAFE_ERROR:
			_show_safe_error(str(payload.get("error_code", "APP_UNKNOWN_ERROR")), str(payload.get("context", "No diagnostic context")))


func select_level(level_id: String) -> void:
	_route_level_id(level_id, false)


func _route_level_id(level_id: String, development_direct: bool) -> void:
	var entry: Dictionary = _entry_by_id(level_id)
	if entry.is_empty():
		_show_safe_error("APP_UNKNOWN_LEVEL_ID", "Catalog has no level ID: " + level_id.left(64))
		return
	if not development_direct and not _progress.is_unlocked(level_id):
		_show_safe_error("APP_LEVEL_LOCKED", "Level prerequisites are not complete")
		return
	var payload: Dictionary = {
		"level_id": str(entry.get("level_id", "")),
		"level_path": str(entry.get("level_path", "")),
		"hud_mode": str(entry.get("hud_mode", "")),
		"classification": str(entry.get("classification", "")),
		"development_direct": development_direct,
		"final_level": bool(entry.get("final_level", false)),
	}
	var gameplay: Node = GameplayScene.instantiate()
	if not gameplay.has_method("configure_route_payload") or not gameplay.configure_route_payload(payload):
		gameplay.free()
		_show_safe_error("APP_GAMEPLAY_CONFIGURATION_FAILED", "Gameplay rejected the validated route payload")
		return
	_gameplay_completion_handled = false
	if gameplay.has_signal("gameplay_completed"):
		gameplay.gameplay_completed.connect(_on_gameplay_completed.bind(gameplay))
	if gameplay.has_signal("request_back"):
		gameplay.request_back.connect(_on_gameplay_request_back.bind(gameplay))
	_replace_screen(gameplay, ROUTE_GAMEPLAY)


func _show_main_menu() -> void:
	var screen: Node = MainMenuScene.instantiate()
	screen.play_requested.connect(func(): navigate(ROUTE_LEVEL_SELECT))
	screen.quit_requested.connect(func(): get_tree().quit())
	_replace_screen(screen, ROUTE_MAIN_MENU)


func _show_level_select() -> void:
	var screen: Node = LevelSelectScene.instantiate()
	screen.configure(_catalog.entries, _progress)
	screen.level_selected.connect(select_level)
	screen.back_requested.connect(func(): navigate(ROUTE_MAIN_MENU))
	_replace_screen(screen, ROUTE_LEVEL_SELECT)


func _show_safe_error(code: String, context: String) -> void:
	var screen: Node = SafeErrorScene.instantiate()
	screen.configure(code, context)
	screen.main_menu_requested.connect(func():
		if _catalog.is_empty():
			_show_safe_error("APP_CATALOG_UNAVAILABLE", "A valid catalog is required before Main Menu")
		else:
			navigate(ROUTE_MAIN_MENU)
	)
	_replace_screen(screen, ROUTE_SAFE_ERROR)


func _replace_screen(screen: Node, route_id: String) -> void:
	if _active_screen != null and is_instance_valid(_active_screen):
		route_host.remove_child(_active_screen)
		_active_screen.queue_free()
	_active_screen = screen
	_current_route = route_id
	route_host.add_child(screen)


func _on_gameplay_completed(level_id: String, turns: int, gameplay: Node) -> void:
	if _gameplay_completion_handled or _current_route != ROUTE_GAMEPLAY or gameplay != _active_screen:
		return
	var payload: Dictionary = gameplay.get_route_payload() if gameplay.has_method("get_route_payload") else {}
	if str(payload.get("level_id", "")) != level_id:
		return
	_gameplay_completion_handled = true
	var recorded: bool = false
	if _test_profile_configured:
		recorded = _record_configured_completion(level_id, turns)
	elif _progress != null:
		recorded = _progress.record_completion(level_id, turns)
	if recorded and not bool(payload.get("final_level", false)):
		navigate(ROUTE_LEVEL_SELECT)


func _record_configured_completion(level_id: String, turns: int) -> bool:
	if _profile_adapter == null or _profile_store == null:
		return _configured_completion_failed("PROFILE_SESSION_NOT_READY")
	var prepared: Dictionary = _profile_adapter.prepare_completion(level_id, turns)
	if not bool(prepared.get("ok", false)):
		return _configured_completion_failed(str(prepared.get("status", "PREPARE_FAILED")))
	var prepare_status: String = str(prepared.get("status", "PREPARE_FAILED"))
	if prepare_status == "NO_CHANGE":
		_profile_persist_status = "NO_CHANGE"
		return true
	if prepare_status != "CANDIDATE_READY":
		return _configured_completion_failed(prepare_status)
	var candidate: Dictionary = (prepared.get("profile", {}) as Dictionary).duplicate(true)
	var persisted: Dictionary = _profile_store.persist_profile(candidate)
	var persist_status: String = str(persisted.get("status", "PERSIST_FAILED"))
	_profile_persist_status = persist_status
	if not bool(persisted.get("ok", false)) or not PROFILE_PERSIST_ACCEPTED_STATUSES.has(persist_status):
		return _configured_completion_failed(persist_status)
	var committed: Dictionary = _profile_adapter.commit_profile(candidate)
	if not bool(committed.get("ok", false)):
		return _configured_completion_failed(str(committed.get("status", "COMMIT_FAILED")))
	_profile_persist_status = "COMMITTED_AFTER_" + persist_status
	return true


func _configured_completion_failed(status: String) -> bool:
	_profile_persist_status = "FAILED_" + status.left(64)
	_show_safe_error("APP_TEST_PROFILE_COMPLETION_FAILED", "Test Profile completion could not be committed (" + status.left(64) + ")")
	return false


func _on_gameplay_request_back(gameplay: Node) -> void:
	if _current_route == ROUTE_GAMEPLAY and gameplay == _active_screen:
		navigate(ROUTE_LEVEL_SELECT)


func _entry_by_id(level_id: String) -> Dictionary:
	var entries: Array = _catalog.get("entries", [])
	for entry_value: Variant in entries:
		if entry_value is Dictionary:
			var entry: Dictionary = entry_value
			if str(entry.get("level_id", "")) == level_id:
				return entry
	return {}


func get_current_route() -> String:
	return _current_route


func get_active_screen_count() -> int:
	var count: int = 0
	for child_value: Variant in route_host.get_children():
		var child: Node = child_value
		if not child.is_queued_for_deletion():
			count += 1
	return count


func get_active_screen() -> Node:
	return _active_screen


func get_catalog_snapshot() -> Dictionary:
	return _catalog.duplicate(true)


func get_progress_snapshot() -> Dictionary:
	var source: Dictionary = {}
	if _test_profile_configured and _profile_adapter != null:
		var adapter_snapshot: Dictionary = _profile_adapter.snapshot()
		source = (adapter_snapshot.get("runtime", {}) as Dictionary).duplicate(true)
	elif not _test_profile_configured and _progress != null:
		source = (_progress.snapshot() as Dictionary).duplicate(true)
	return _bounded_progress_snapshot(source)


func _bounded_progress_snapshot(source: Dictionary) -> Dictionary:
	var completed: Array = (source.get("completed_level_ids", []) as Array).duplicate(true)
	var best_turns: Dictionary = (source.get("best_turns", {}) as Dictionary).duplicate(true)
	var unlocked: Array = (source.get("unlocked_level_ids", []) as Array).duplicate(true)
	return {
		"completed_level_ids": completed,
		"best_turns": best_turns,
		"unlocked_level_ids": unlocked,
	}


func get_test_profile_session_snapshot() -> Dictionary:
	return {
		"mode": "TEST_PROFILE" if _test_profile_configured else "MEMORY_ONLY",
		"configured": _test_profile_configured,
		"boot_status": _profile_boot_status,
		"load_status": _profile_load_status,
		"persist_status": _profile_persist_status,
		"progress": get_progress_snapshot(),
	}


func set_test_profile_failure_seam(stage: String) -> Dictionary:
	if _profile_store == null:
		return {
			"ok": false,
			"status": "APP_PROFILE_STORE_NOT_READY",
			"configured": _test_profile_configured,
		}
	if not PROFILE_FAILURE_SEAM_STAGES.has(stage):
		return {
			"ok": false,
			"status": "FAILURE_SEAM_REJECTED",
			"configured": _test_profile_configured,
		}
	var forwarded: Dictionary = _profile_store.set_test_failure_seam(stage)
	return {
		"ok": bool(forwarded.get("ok", false)),
		"status": str(forwarded.get("status", "FAILURE_SEAM_REJECTED")),
		"configured": _test_profile_configured,
	}


func _profile_configuration_rejected(status: String) -> Dictionary:
	return {
		"ok": false,
		"status": status,
		"configured": _test_profile_configured,
		"mode": "TEST_PROFILE" if _test_profile_configured else "MEMORY_ONLY",
	}


func get_window_presentation_snapshot(client_size: Vector2i = Vector2i.ZERO) -> Dictionary:
	var measured_size: Vector2i = DisplayServer.window_get_size() if client_size == Vector2i.ZERO else client_size
	var snapshot: Dictionary = WindowPresentation.content_transform(measured_size)
	snapshot["logical_size"] = WindowPresentation.LOGICAL_SIZE
	snapshot["bar_color"] = WindowPresentation.BAR_COLOR
	snapshot["route"] = _current_route
	snapshot["route_host"] = route_host.name
	return snapshot
