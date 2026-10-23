# Factorio 2.1 notes

Tested with **Factorio 2.1.23**. Current fork version: **1.0.5**.

## Changes

- Rebased the fork onto upstream 2.2.5 for Factorio 2.1.
- Retained the custom rotation, belt placement, blueprint and belt-matched recipe fixes.
- Updated underground-belt lookup and companion-mod identities.

## Tests

- 1,152 connected rotations, eight free rotations and 72 reverse-facing belt snaps per round.
- 288 actual robot-built rotated/mirrored blueprint cases transferred items per round.
- After restart/rejoin, 432 saved configurations were checked and the full matrix passed again without a detected desync.

Localhost with the installed base/Space Age/Matt’s profile. Not a WAN or long-duration stress test.

Tests used private copies of saves and local host/client sessions. Raw player data and test hooks are not shipped.
