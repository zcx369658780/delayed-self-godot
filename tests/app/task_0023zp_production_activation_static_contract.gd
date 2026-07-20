extends SceneTree

const PROJECT_GODOT_SHA256: String = "faeb4a90b435aa81bd1c122ee12972e82db8dd5a90c448e850781e3d4b88c0d2"
const AUTHORIZED_PRODUCT_PATHS: Array[String] = [
	"res://scenes/app/app_bootstrap.tscn",
	"res://scripts/app/app_bootstrap.gd",
	"res://scripts/app/app_root.gd",
	"res://scripts/app/local_profile.gd",
	"res://scripts/app/profile_codec.gd",
]
const FROZEN_SHA256: Dictionary = {
	"res://scripts/app/catalog_loader.gd": "ce18165de39bff20e1bf57fa4eb18d5ed91bd268aa80953568007994e2ff7f7d",
	"res://scripts/app/memory_progress.gd": "41651ebcff17fd09247c3e5e820fff940c896efc25c5ba17ee7af668bbd4d567",
	"res://scripts/app/profile_progress_adapter.gd": "4c35ee3f0ec1c932ab30ffa3c3130870a3febfc7b2f2a6a219efd2a819f5f563",
	"res://scripts/app/route_request.gd": "63e72c4c2b268d7909892665e1bdfb606a3992e5b1fe0f976b188032f66b561d",
	"res://scenes/app/app_root.tscn": "8801addede59631e15e8ee98aa49a8b438536f2e5ef1df7441d9fc5a06248d91",
	"res://data/catalog/level_catalog_v1.json": "a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51",
}

var assertions: int = 0
var failures: int = 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var bootstrap: String = _read_text("res://scripts/app/app_bootstrap.gd")
	var bootstrap_scene: String = _read_text("res://scenes/app/app_bootstrap.tscn")
	var app_root: String = _read_text("res://scripts/app/app_root.gd")
	var store: String = _read_text("res://scripts/app/local_profile.gd")
	var codec: String = _read_text("res://scripts/app/profile_codec.gd")
	var project: String = _read_text("res://project.godot")
	_validate_bootstrap(bootstrap, bootstrap_scene, project)
	_validate_configuration_surfaces(app_root, store)
	_validate_codec(codec)
	_validate_ordering_and_disclosure(app_root, store, bootstrap)
	_validate_frozen_surfaces()
	print("TASK_0023ZP_ASSERTIONS=%d" % assertions)
	if failures == 0:
		print("TASK_0023ZP_PRODUCTION_ACTIVATION_STATIC_CONTRACT_PASS")
		quit(0)
	else:
		print("TASK_0023ZP_PRODUCTION_ACTIVATION_STATIC_CONTRACT_FAIL failures=%d" % failures)
		quit(1)


func _validate_bootstrap(source: String, scene: String, project: String) -> void:
	_expect(source.contains("class_name DelayedSelfAppBootstrap"), "bootstrap_class")
	_expect(scene.contains("res://scripts/app/app_bootstrap.gd"), "bootstrap_scene_script")
	_expect(project.contains('run/main_scene="res://scenes/app/app_root.tscn"'), "main_scene_memory_only")
	_expect(not project.contains("app_bootstrap.tscn"), "bootstrap_not_main_scene")
	_expect(FileAccess.get_sha256("res://project.godot") == PROJECT_GODOT_SHA256, "project_godot_byte_identical")
	_expect(not project.contains("[autoload]"), "no_autoload")
	_expect(source.contains('var _selected_policy: String = MEMORY_ONLY'), "bootstrap_default_memory_only")
	_expect(source.contains("MEMORY_ONLY") and source.contains("PRODUCTION_READ_ONLY") and source.contains("PRODUCTION_WRITE_ON_INTENT"), "three_boot_policies")
	_expect(source.contains("const BOOT_POLICIES: Array[String]"), "boot_policy_allowlist")
	_expect(source.contains("RouteRequest.parse_user_args(arguments)"), "arguments_classified")
	_expect(source.find("RouteRequest.parse_user_args(arguments)") < source.find("app_root.configure_production_profile(access_policy)"), "classification_before_production_configuration")
	_expect(source.find("app_root.configure_production_profile(access_policy)") < source.find("add_child(app_root)"), "configuration_before_tree_entry")
	_expect(source.contains('effective = MEMORY_ONLY'), "direct_or_invalid_memory_only")
	_expect(source.count("AppRootScene.instantiate()") == 1, "exactly_one_app_root_instantiation_site")
	_expect(not source.contains("navigate(") and not source.contains("load_profile(") and not source.contains("persist_profile(") and not source.contains("reset_test_profile("), "bootstrap_not_router_or_store")


func _validate_configuration_surfaces(app_root: String, store: String) -> void:
	var app_configure: String = _function_block(app_root, "func configure_production_profile", "func boot_with_user_args")
	var store_configure: String = _function_block(store, "func configure_production", "func is_configured")
	_expect(app_configure.contains("access_policy: String") and not app_configure.contains("path:"), "app_configure_policy_no_path")
	_expect(store_configure.contains("access_policy: String") and not store_configure.contains("path:"), "store_configure_policy_no_path")
	_expect(not _contains_io(app_configure), "app_configuration_zero_io")
	_expect(not _contains_io(store_configure), "store_configuration_zero_io")
	_expect(store_configure.contains("_target_path = PRODUCTION_PROFILE_PATH"), "production_path_internal_binding")
	_expect(store.count('user://delayed_self_profile.json') == 1, "production_path_only_store_literal")
	_expect(not app_root.contains('user://delayed_self_profile.json'), "app_root_no_production_path")
	_expect(app_root.contains("_test_profile_configured or _production_profile_configured"), "app_modes_mutually_exclusive")
	_expect(store.contains("if _configured:") and store.contains("PRODUCTION_STORE_ALREADY_CONFIGURED"), "store_configuration_immutable")
	_expect(app_configure.contains("is_inside_tree() or _boot_started"), "app_pre_tree_only")
	_expect(store.contains("const MODE_TEST: String") and store.contains("const MODE_PRODUCTION: String"), "store_modes_typed")
	_expect(store.contains("const ACCESS_READ_ONLY: String") and store.contains("const ACCESS_WRITE_ON_INTENT: String"), "store_access_policies_typed")
	_expect(store.contains("if _mode != MODE_TEST:") and store.count("TEST_MODE_REQUIRED") >= 2, "test_reset_and_seam_mode_gated")
	_expect(store.find("PRODUCTION_WRITE_POLICY_REJECTED") < store.find("ProfileCodec.normalize_profile(candidate_profile"), "read_only_rejects_before_persist_work")
	_expect(store.contains("_access_policy != ACCESS_WRITE_ON_INTENT") and store.contains("func _preserve_recovery_copy"), "read_only_rejects_recovery")


func _validate_codec(codec: String) -> void:
	var classifier: String = _function_block(codec, "static func classify_profile_schema", "static func default_profile")
	_expect(classifier.contains("PROFILE_ROOT_INVALID"), "classifier_root_invalid")
	_expect(classifier.contains("PROFILE_VERSION_INVALID"), "classifier_version_invalid")
	_expect(classifier.contains("PROFILE_VERSION_SUPPORTED"), "classifier_supported")
	_expect(classifier.contains("PROFILE_VERSION_UNSUPPORTED"), "classifier_unsupported")
	_expect(not _contains_io(classifier), "classifier_zero_io")
	_expect(not classifier.contains("normalize_profile") and not classifier.contains("serialize_profile"), "classifier_pure_shape_only")


func _validate_ordering_and_disclosure(app_root: String, store: String, bootstrap: String) -> void:
	var boot: String = _function_block(app_root, "func _boot_configured_profile", "func _configured_boot_failed")
	_expect(boot.find("adapter.configure(_catalog)") < boot.find("store.configure_production"), "adapter_before_store_configuration")
	_expect(boot.find("store.configure_production") < boot.find("store.load_profile()"), "store_configuration_before_load")
	_expect(boot.find("store.load_profile()") < boot.find("adapter.load_profile(loaded_profile)"), "load_before_hydrate")
	var completion: String = _function_block(app_root, "func _record_configured_completion", "func _configured_completion_failed")
	_expect(completion.find("prepare_completion") < completion.find('prepare_status == "NO_CHANGE"'), "prepare_before_no_change")
	_expect(completion.find('prepare_status == "NO_CHANGE"') < completion.find("persist_profile(candidate)"), "no_change_before_persist")
	_expect(completion.find("persist_profile(candidate)") < completion.find("commit_profile(candidate)"), "persist_before_commit")
	_expect(app_root.contains('"APP_PROFILE_BOOT_FAILED"'), "bounded_production_boot_error")
	_expect(app_root.contains('"APP_PROFILE_COMPLETION_FAILED"'), "bounded_production_completion_error")
	_expect(not _public_blocks(app_root).contains("PRODUCTION_PROFILE_PATH"), "public_app_surfaces_no_path")
	_expect(store.contains("if _mode == MODE_TEST and not _recovery_sibling_name.is_empty()"), "production_result_hides_sibling")
	_expect(store.contains(".delayed_self_profile_") and store.contains(".delayed_self_0023w_"), "production_siblings_distinct")
	_expect(store.find("intended_json == _committed_json") < store.find("_preserve_activation_backup()"), "no_change_before_activation_backup")
	_expect(store.find("_preserve_activation_backup()") < store.find("_transactional_replace(intended_json)"), "activation_backup_before_replace")
	_expect(store.contains("RECOVERY_REQUIRED_READ_ONLY") and store.contains("UNSUPPORTED_VERSION_READ_ONLY"), "read_only_bounded_load_statuses")
	_expect(store.contains("UNSUPPORTED_VERSION_PRESERVED") and store.contains("_write_disabled = true"), "unsupported_preserved_write_disabled")
	_expect(app_root.contains('"completed_level_ids": completed') and app_root.contains('"best_turns": best_turns') and app_root.contains('"unlocked_level_ids": unlocked'), "public_progress_three_keys")
	_expect(not bootstrap.contains("_profile_store") and not bootstrap.contains("_profile_adapter"), "bootstrap_no_internal_objects")
	_expect(AUTHORIZED_PRODUCT_PATHS.size() == 5, "authorized_product_path_cardinality")


func _validate_frozen_surfaces() -> void:
	for path_value: Variant in FROZEN_SHA256.keys():
		var path: String = str(path_value)
		_expect(FileAccess.get_sha256(path) == str(FROZEN_SHA256.get(path, "")), "frozen_" + path.get_file().to_snake_case())


func _function_block(source: String, start_marker: String, end_marker: String) -> String:
	var start: int = source.find(start_marker)
	var finish: int = source.find(end_marker, start + start_marker.length())
	if start < 0 or finish < 0:
		return ""
	return source.substr(start, finish - start)


func _contains_io(source: String) -> bool:
	return source.contains("FileAccess") or source.contains("DirAccess") or source.contains("globalize_path")


func _public_blocks(app_root: String) -> String:
	return _function_block(app_root, "func get_progress_snapshot", "func get_window_presentation_snapshot")


func _read_text(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return ""
	var text: String = file.get_as_text()
	file.close()
	return text


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		print("TASK_0023ZP_ASSERT_FAIL label=" + label)
