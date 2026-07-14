# Development environment (CURRENT)

- Observation date: 2026-07-14 (Asia/Shanghai)
- Inventory task: `tasks/0001_readonly_environment_and_release_target_inventory.md`
- GPT acceptance: [`0001_GPT_FINAL_ACCEPTANCE.md`](../reports/0001_GPT_FINAL_ACCEPTANCE.md)
- Evidence status: read-only local observation; no editor launch, project initialization, import, export, build, installation, upgrade, or machine configuration change
- Decision status: Task 0001 recommendations were accepted and frozen for Task 0002/vertical-slice planning; runtime/export facts remain unverified

## Machine and operating system

| Item | Observed fact | Limitation / relevance |
|---|---|---|
| OS | Microsoft Windows 11 Pro, version `10.0.26200`, build `26200`, 64-bit | Windows desktop is the canonical primary target; no export was attempted |
| CPU | Intel Core Ultra 7 265K, 20 logical processors | No benchmark was run |
| Memory | 31.49 GiB physical memory | No runtime/project workload exists to measure |
| Discrete GPU | NVIDIA GeForce RTX 5070, driver `32.0.15.9649` | NVML returned `Unknown Error`; WMI's 4 GiB adapter-RAM value may be truncated, so exact VRAM is `UNKNOWN` |
| Integrated GPU | Intel Graphics, driver `32.0.101.8801`; WMI reported 2 GiB adapter RAM | Shared/dedicated memory interpretation was not established |
| Active display observation | 2560×1440 at 120 Hz; Dell U2724D also reported | CIM returned duplicate/default monitor records; exact multi-display topology is inconclusive |

No obvious CPU/RAM/GPU capacity blocker is visible for the intended small 2D game, but this is not performance evidence.

## Godot candidates

| Candidate | Observed fact |
|---|---|
| Executable | `D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe` |
| Discovery | PowerShell `godot` alias points to the executable; bounded PATH/common-folder checks found no second credible installation |
| File/product metadata | File version `4.7`; product version `4.7.stable.steam` |
| Read-only version result | `4.7.stable.steam.5b4e0cb0f`, exit code 0 |
| Build / architecture | Standard non-.NET tools build; PE machine `0x8664` (x64) |
| Console availability | Version output works from the main executable; no separate editor console sibling was present |
| User-data mode | Existing installation-local `editor_data` indicates self-contained/portable data; it predates this inventory |

No Godot UI was opened. The repository and Godot user-data timestamps/state showed no inventory-created project/editor state.

## Export templates

Installed engine release line `4.7.stable` matches the existing installation-local template directory:

`D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\editor_data\export_templates\4.7.stable`

No template root exists at `%APPDATA%\Godot\export_templates` or `%LOCALAPPDATA%\Godot\export_templates`; that is expected for this self-contained installation.

| Platform / route | Template evidence | Classification |
|---|---|---|
| Windows desktop x86_64 | Matching debug/release and console/non-console templates present | `AVAILABLE_FOR_LATER_SMOKE_TEST` |
| Windows x86_32 / ARM64 | Matching debug/release variants present but not project targets | `AVAILABLE_FOR_LATER_SMOKE_TEST` |
| Web | Matching debug/release, threaded/non-threaded, and dlink archives present | `AVAILABLE_FOR_LATER_SMOKE_TEST` |
| .NET/Mono export | No .NET editor candidate was found; recommended standard GDScript route does not require it | `NOT_APPLICABLE` |

Template presence is not export readiness. No project, `export_presets.cfg`, export, browser run, or Windows smoke test exists.

## Development tools

| Tool | Observed version / status | Relevance |
|---|---|---|
| Git | 2.53.0.windows.1 | Available |
| GitHub CLI | 2.91.0 | Available; no account operation was performed |
| PowerShell | 7.6.1 Core | Available |
| Python | `python` 3.11.9; launcher default 3.14.3 | Multiple versions require explicit interpreter choice in future scripts |
| pip | 24.0 for Python 3.11 | Available; no package operation was performed |
| Node.js / npm | 24.14.0 / 11.9.0 | Available; not currently required |
| FFmpeg | Not found in bounded command lookup | Optional video pipeline gap; not a Task 0002 blocker |
| ImageMagick | Not found in bounded command lookup | Optional image pipeline gap |
| Image editor | Microsoft Paint 11.2603.251.0 found; no Krita/GIMP/Aseprite/paint.net found in bounded checks | Art workflow remains undecided |
| Archive tools | 7-Zip 26.00 x64; bsdtar 3.8.4 | Available |
| Hash tools | PowerShell `Get-FileHash` and Windows `certutil` available | Suitable for later evidence hashes |
| Browsers | Edge 150.0.4078.65 and Chrome 150.0.7871.114 present | Only browser presence was checked; no Web build was run |
| Godot-specific tests | `gdlint`, `gdformat`, `gdtoolkit`, and `gut` commands not found | Test approach remains a later task decision; no installation authorized |

## Drives and evidence path

| Location | Filesystem / capacity | Observation |
|---|---|---|
| `C:` | NTFS, 299.19 GiB total, 34.10 GiB free | Tool/user-data drive; limited relative free space |
| `D:` | NTFS, 631.30 GiB total, 180.93 GiB free | Repository drive and preferred evidence drive |
| `D:\Delayed_Self` | Canonical repository root on `D:` | Confirmed |
| `D:\Delayed_Self_Evidence` | Does not exist | No conflict observed; directory was not created |

Recommended evidence root for approval: `D:\Delayed_Self_Evidence`.

## Release-target decision matrix

| Target | Observed prerequisites | Missing / unverified | Risk | Safest later verification |
|---|---|---|---|---|
| Windows desktop (primary) | Frozen standard Godot 4.7/GDScript/Compatibility baseline; Windows x64 host; matching templates; sufficient disk; hash/archive tools | No Godot project, preset, runtime, export, clean-machine smoke test, or performance evidence | `LOW` | After Task 0002/0003, create the authorized minimal project and run a separately authorized Windows debug-export smoke test |
| Web (deferred) | Frozen Compatibility renderer baseline; matching Web templates and current Edge/Chrome installations | No project/preset, browser run, threading policy, hosting/package test, input/audio/fullscreen compatibility evidence | `MEDIUM` | Keep outside the vertical-slice commitment; after Task 0003 stability, run a separate Compatibility-renderer Web export/browser smoke gate |

Neither target is claimed export-ready.

## Frozen decisions from Task 0001 acceptance

The GPT Project Sources advisor accepted these planning-baseline decisions:

1. Installed standard Godot `4.7.stable` engine line; observed Steam build `4.7.stable.steam.5b4e0cb0f`.
2. Standard GDScript, not .NET/Mono.
3. Compatibility renderer.
4. Windows desktop x86_64 is the only vertical-slice committed platform; Web is a later compatibility gate.
5. `D:\Delayed_Self_Evidence` is the approved repository-external evidence root, but this task does not authorize creating it.

## Unresolved

- No project exists, so import behavior, renderer correctness, runtime performance, export presets, Windows execution, and Web compatibility are unverified.
- Exact discrete-GPU VRAM and full display topology were inconclusive.
- Art style, logic resolution, final license, independent reviewer, and undo support were outside this task and remain pending.

## Read-only source categories

Git startup facts; bounded `Get-CimInstance`/`Get-Volume`; `Get-Command`/`where.exe`; exact common-install-path metadata; Godot `--version`; PE header architecture read; bounded template listings; tool `--version`; exact browser/Appx metadata; `Test-Path`; and Git status checks. No broad drive scan or raw system dump was used.
