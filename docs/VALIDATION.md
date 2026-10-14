# Validation

Baseline: upstream 690af52, version 2.2.4. Runtime: Factorio 2.0.77, Space Age, Matt's Logistics and the local mod set. All tests used isolated write-data, private fixture mods and copied saves.

- Unmodified upstream: rejected by its Factorio 2.1/base >= 2.1.7 metadata.
- Adapted metadata: creates and loads a map on 2.0.77.
- Original rotation: engine-driven R actions reproduce the one-axis cycle defect.
- Fixed rotation: 1,152 actual R/reverse-R actions across nine variants, all four directions and input/output modes.
- Direct placement: 72 adjacency, belt resnapping and iron-plate transfer cases.
- Real construction robots: 72 untagged ghosts with belts and chests already present, including initially reversed housings.
- Tagged ghosts: original blueprint direction overrides the rotated ghost in the baseline; all 72 cases pass after honoring the built entity direction.
- Native build_blueprint: robots construct loader, belt and chest ghosts in differing orders; all 72 direction/mode cases transfer items.
- Mirrored blueprint layouts: all four native rotations and both flow modes across nine variants, 72 cases.
- Save adoption: all 807 existing loader identities and checked configuration fields match their upstream save state. Input stack preferences are recovered from the loader, not the input inserter's forced maximum.

Private fixture code, user saves, multiplayer profiles, logs and credentials are excluded from the published mod. These checks establish behavior for the tested nine variants; optional integrations not installed in the test profile have not been independently exercised.

- Clean release ZIP multiplayer: client joined, loader GUI opened, server saved the migrated world, server restarted from that save and client rejoined successfully. Test dependency Pollution Absorber was updated to the fixed 1.0.3 before this check.
