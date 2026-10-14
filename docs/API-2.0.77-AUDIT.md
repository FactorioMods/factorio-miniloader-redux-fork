# Factorio 2.0.77 API audit — 2026-10-15

Target: Miniloader (Redux) Fork 1.0.1, code commit 020529c.

## Schemas

Official version-pinned runtime and prototype schemas: https://lua-api.factorio.com/2.0.77/runtime-api.json and https://lua-api.factorio.com/2.0.77/prototype-api.json. application_version was verified as 2.0.77.

Runtime SHA256: 594b4ec98cc5fbee322d7380db49a388ab38b0d69c06f00ead877cffbb37f578
Prototype SHA256: 29772ece6140b515d295a504c6f9ac5bc9e653d8b1470e8cd6db825f93fcc756

## Static review

Scanned 72 Lua files, including framework, stdlib, migrations and integrations. Checked engine-global member references, annotated Lua-object member names, all 80 distinct defines references, dynamic loader/inserter circuit keys, and candidate members/prototype properties introduced in the newer 2.1.21 schema. Reviewed scan candidates to distinguish engine objects from local tables, configuration records and library functions.

No additional absent API names were confirmed after 1.0.1. underground_belt_neighbour was the confirmed incompatibility and is replaced with neighbours in scripts/snapping.lua. The bundled framework remains pinned to its upstream RELEASE_4 snapshot.

## Isolated runtime checks

Factorio 2.0.77, private mod directory/write-data and new test worlds; main game and player saves untouched.

- Space Age: all four underground-belt tiers at four orientations (16 cases), unpaired and paired neighbour access, script-raised construction, eight actual robot-built endpoints.
- Base only (Space Age, quality and elevated rails explicitly disabled): three tiers at four orientations (12 cases), eight actual robot-built endpoints.
- Both configurations: actual miniloader creation, dynamic circuit field reads/writes, circuit/logistic conditions, stack overrides, quality item filters, all three spoil-priority enum values and table-form item spilling.
- Both runs completed 1,201 simulation ticks normally, with explicit pass markers for every group.

## Limits

Schema scans are not a complete Lua type checker and cannot prove arbitrary dynamic argument values or every unexecuted branch. Existing rotation, blueprint, migration and multiplayer tests complement this audit. Optional external-mod remote interfaces (Bob's, Krastorio, Space Exploration, etc.) depend on their installed versions and were not revalidated here. No blanket compatibility claim is made for those integrations.

No further gameplay patch or version bump was needed after 1.0.1.
