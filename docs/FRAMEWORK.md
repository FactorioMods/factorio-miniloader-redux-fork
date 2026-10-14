# Bundled framework provenance and compatibility

The framework and stdlib folders are vendored source, not separately installed mods or an SDK selected by Factorio.

- Origin: https://github.com/hgschmie/factorio-core-libs
- Imported by upstream Miniloader Redux commit 690af52559b33db968515bdbe87c9114b6cdbd6b (`framework RELEASE_4`).
- Source library snapshot: 8fa88b0f8271d07b6b27725bd977c24d4bb0c5a9, RELEASE_4.
- The fork currently retains those framework/stdlib files unchanged.
- Target engine: Factorio 2.0.77. The upstream mod baseline targeted 2.1.7, so API use must be backported independently of package metadata.

The framework provides settings, GUI, blueprint/ghost handling, persistent state and event helpers. Replacing it wholesale with an older snapshot can change storage, callbacks and blueprint semantics. Keep the snapshot pinned and adapt demonstrated incompatible engine calls with regression tests.

The 1.0.1 crash fix is in scripts/snapping.lua, not framework: underground_belt_neighbour is unavailable in 2.0.77; neighbours returns the connected underground endpoint. Verified 16 tier/direction cases and eight actual robot-built endpoints. Existing GUI, blueprint, save/reload and multiplayer tests exercised the bundled helpers; this is not proof that every unused library function supports every engine version.
