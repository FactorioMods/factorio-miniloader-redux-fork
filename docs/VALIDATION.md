# Miniloader tests

Factorio 2.1.23, fork 1.0.5; based on upstream 2.2.5.

- 1,152 connected rotations, eight free rotations and 72 reverse-facing belt snaps per round.
- 288 actual robot-built rotated/mirrored blueprint cases transferred items per round.
- After restart/rejoin, 432 saved configurations were checked and the full matrix passed again without a detected desync.

Robot cases used actual construction events and physical item transfer, including rotated and mirrored blueprints. Two complete rounds were separated by server save/restart and client rejoin.

Connected rotation preserves the chosen axis and input/output mode. A perpendicular side belt is not an auto-placement target. Existing loaders and saved settings were checked after reload.

Localhost with the installed base/Space Age/Matt’s profile. Not a WAN or long-duration stress test. Private fixtures and player saves are not distributed.
