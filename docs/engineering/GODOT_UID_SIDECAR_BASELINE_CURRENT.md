# Godot UID sidecar baseline (CURRENT)

- Reviewed sidecars: 66
- Adopted valid pairs: 66
- Rejected or removed: 0

Each adopted sidecar is adjacent to an eligible repository `.gd` source, contains exactly one `uid://` declaration, and has a UID unique across the reviewed set. Eligible sources are tracked scripts plus the authorized Task 0023ZX focused test script. Future script/shader changes must commit their reviewed unique adjacent `.uid` sidecar together; valid sidecars are not blanket-ignored.
