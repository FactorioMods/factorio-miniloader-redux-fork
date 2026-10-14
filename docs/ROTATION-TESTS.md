# Connected rotation regression — 2026-10-15

Factorio 2.0.77, private instance and copied validation save. Version 1.0.2 fixes the prior eight-state cycle turning connected loaders away from their belt/container axis.

Nine variants (base, Space Age and Matt's), four facings, two flow directions: 72 layouts. Each received eight actual player-triggered forward and eight reverse rotations (1,152 actions). Assertions checked fixed configuration direction, alternating mode, correct internal conveyor flow, stable loader/inserter unit numbers and unchanged adjacent belt direction. No synthetic rotation events were used.

An unconnected loader visited eight unique orientation/mode states and returned to its starting state. Real robots constructed all 72 belt/chest/loader layouts, with direction/mode assertions and actual iron-plate transfer. All passed. Existing underground-belt API hotfix retained.

Changing input/output reverses the internal belt's flow by design; its physical connection axis stays fixed. Manual mode selection may oppose an adjacent belt's flow until the player changes that belt. Automatic placement still matches the belt's flow. These tests do not measure production UPS.
