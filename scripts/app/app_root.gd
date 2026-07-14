class_name DelayedSelfAppRoot
extends Node

const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const MemoryProgress = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
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

@export var catalog_path := "res://data/catalog/level_catalog_v1.json"

var _catalog: Dictionary = {}
var _progress
var _current_route := ROUTE_BOOT
var _active_screen: Node

@onready var route_host: Control = $RouteHost


func _ready() -> void:
	boot_with_user_args(OS.get_cmdline_user_args())


func boot_with_user_args(arguments: PackedStringArray) -> void:
	_current_route = ROUTE_BOOT
	var loaded := CatalogLoader.new().load_file(catalog_path)
	if not loaded.ok:
		var first: Dictionary = loaded.errors[0] if not loaded.errors.is_empty() else {"code": "CATALOG_INVALID", "message": "Catalog validation failed"}
		_show_safe_error(first.code, first.message)
		return
	_catalog = loaded.catalog
	_progress = MemoryProgress.new(_catalog)
	var request := RouteRequest.parse_user_args(arguments)
	if not request.ok:
		_show_safe_error(request.status, "Invalid development direct-level request")
	elif request.status == "DIRECT_LEVEL_REQUEST":
		_route_level_id(request.level_id, true)
	else:
		navigate(ROUTE_MAIN_MENU)


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
	var entry := _entry_by_id(level_id)
	if entry.is_empty():
		_show_safe_error("APP_UNKNOWN_LEVEL_ID", "Catalog has no level ID: " + level_id.left(64))
		return
	if not development_direct and not _progress.is_unlocked(level_id):
		_show_safe_error("APP_LEVEL_LOCKED", "Level prerequisites are not complete")
		return
	var payload := {
		"level_id": entry.level_id,
		"level_path": entry.level_path,
		"hud_mode": entry.hud_mode,
		"classification": entry.classification,
		"development_direct": development_direct,
		"final_level": entry.final_level,
	}
	var gameplay = GameplayScene.instantiate()
	if not gameplay.has_method("configure_route_payload") or not gameplay.configure_route_payload(payload):
		gameplay.free()
		_show_safe_error("APP_GAMEPLAY_CONFIGURATION_FAILED", "Gameplay rejected the validated route payload")
		return
	if gameplay.has_signal("gameplay_completed"):
		gameplay.gameplay_completed.connect(_on_gameplay_completed)
	if gameplay.has_signal("request_back"):
		gameplay.request_back.connect(func(): navigate(ROUTE_LEVEL_SELECT))
	_replace_screen(gameplay, ROUTE_GAMEPLAY)


func _show_main_menu() -> void:
	var screen = MainMenuScene.instantiate()
	screen.play_requested.connect(func(): navigate(ROUTE_LEVEL_SELECT))
	screen.quit_requested.connect(func(): get_tree().quit())
	_replace_screen(screen, ROUTE_MAIN_MENU)


func _show_level_select() -> void:
	var screen = LevelSelectScene.instantiate()
	screen.configure(_catalog.entries, _progress)
	screen.level_selected.connect(select_level)
	screen.back_requested.connect(func(): navigate(ROUTE_MAIN_MENU))
	_replace_screen(screen, ROUTE_LEVEL_SELECT)


func _show_safe_error(code: String, context: String) -> void:
	var screen = SafeErrorScene.instantiate()
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


func _on_gameplay_completed(level_id: String, turns: int) -> void:
	if _progress != null and _progress.record_completion(level_id, turns):
		navigate(ROUTE_LEVEL_SELECT)


func _entry_by_id(level_id: String) -> Dictionary:
	for entry in _catalog.get("entries", []):
		if entry.level_id == level_id:
			return entry
	return {}


func get_current_route() -> String:
	return _current_route


func get_active_screen_count() -> int:
	var count := 0
	for child in route_host.get_children():
		if not child.is_queued_for_deletion():
			count += 1
	return count


func get_active_screen() -> Node:
	return _active_screen


func get_catalog_snapshot() -> Dictionary:
	return _catalog.duplicate(true)


func get_progress_snapshot() -> Dictionary:
	return _progress.snapshot() if _progress != null else {}
