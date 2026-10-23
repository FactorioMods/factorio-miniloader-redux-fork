# Using Miniloader Redux

A compact loader that can replace inserters in many situations when loading from/to a belt.

Miniloaders can have different modes:

## Features

- 1x1 compact size
- Extended UI
- can be moved with [Even Pickier Dollies](https://mods.factorio.com/mod/even-pickier-dollies)
- flips through belt directions and orientation when rotating
- supports Fast replacement, Blueprinting, Copy&Paste, Cloning
- supports undo/redo for configuration changes
- supports parameterized blueprints
- supports migrating 1.1 games from the "old" Miniloaders to Miniloader (Redux) with a startup setting
- when stacking is available (Space Age), stacking is supported by "Vanilla", Fast and Turbo loaders

There are three tiers in the base game ("Vanilla", Fast and Express) and four when playing Space Age (adds Turbo mode) which match the belt speeds.

A simple "chute" loader is available early in the game (enable in Startup settings). The chute loader only supports normal mode and has no GUI.

## Operation Modes

### _Normal mode_ (which is the default)

- supports sideloading from/to a belt
- In Space Age, supports spoilage priority
- degrades with belts above 240 items/sec (The fastest "official" in-game belts are Space Age Turbo Belts, which move at 60 items/sec)

### _Speed mode_

- can only interact with entities that are a container or container-like (e.g. cargo wagons or assembly machines)
- supports speeds up to 480 items/sec

### _Lane filter mode_

- only available in Speed Mode
- has a single filter for each lane, one for the left lane and one for the right lane

![All supported Loader types](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/all-belts.gif)
![All supported Stacking Loader types](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/all-belts-stacked.gif)
![Lane Filter Mode](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/lane-filter.gif)
![Sideloading from/to a belt](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/sideloading.gif)
![Extended rotation](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/extended_rotation.gif)
![Moving Miniloaders](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/picker-dollies.gif)
![Normal Mode GUI](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/normal-mode-gui.png)
![Speed Mode GUI](https://raw.githubusercontent.com/hgschmie/factorio-miniloader-redux/refs/heads/main/portal/speed-mode-gui.png)

Miniloader supports some other mods:

- [Matt's Logistics](https://mods.factorio.com/mod/matts-logistics)
- [Krastorio 2](https://mods.factorio.com/mod/Krastorio2)
- [Bob's Logistics](https://mods.factorio.com/mod/boblogistics)
- [Advanced Furnaces 2 SpaceAgeFix](https://mods.factorio.com/mod/Load-Furn-2-SpaceAgeFix)
- [Space Exploration](https://mods.factorio.com/mod/space-exploration)
- [TurboBelt](https://mods.factorio.com/mod/TurboBelt)

These miniloaders are activated if the corresponding module is detected.

Getting the speeds for additional tiers beyond the basic levels (base games and Space Age DLC) is tricky and the game mechanics are stretched when going faster than ~ 120 items/sec. Supporting faster loaders is at best unreliable and might be outright wrong. YMMV.

I am open to support additional tiers from other mods from PRs but I do not plan to actively add any support for other mods. See [adding more miniloaders for other mods](https://github.com/hgschmie/factorio-miniloader-redux/blob/main/ADD_NEW_LOADERS.md) for details on how to add loaders for other belt tiers.

## Limitations

- High speed (> 120 items/sec) miniloaders will only achieve maximum throughput when using Speed Mode.
- When sideloading in Normal Mode onto a belt with High speed miniloaders, they may spray items across both lanes of the belt they are loading to.
- Stacking (in Space Age) is only available for some Miniloaders. Stacking for the "Turbo" miniloader is equivalent to the pre-1.0 Stacking miniloader. Existing Stacking Miniloaders are converted to "Turbo" Miniloaders.

### Blueprint compatibility

All Miniloader versions can read blueprints that were created with older versions of the Miniloader. Especially, any version after 1.0.0 can read blueprints created with versions before 1.0.0.

When downgrading the Miniloader to a version before 1.0.0, it _must_ be the latest version before 1.0.0 (currently that is 0.13.2) as this will be the only version that supports reading newer blueprints and converting them back to the pre-1.0.0 format. Any other version may crash the game, not read the blueprint or behave in an undefined way.

### Item spilling

Starting with 1.0.0, Miniloader supports multiple modes which require rebuilding the actual loader itself. When doing this, items that are currently in the loader would be lost. Similar, when changing filters, it is possible that items get stuck inside the loader which would stop it from functioning.

If a Miniloader is pushing into or pulling from a chest, it will try to move such items back into the chest. However, if the chest is full, the Miniloader can either spill the items around its position (and mark the items for pickup by robots) or silently discard those. For high value items (such as science packs or processing units), spilling is better, for low value items (ores, plates etc.), discarding is more convenient because there are no items lying around.

There is a startup setting that defines the default for new miniloaders and each miniloader can be individually configured through the GUI. The setting is preserved in blueprints and through copy-paste.

### FAQs

#### I get an error about some "collision_mask" problems, how can I fix this?

When using Miniloaders with some other mods (most prominent offender seems to be the [Advanced Furnaces 2 SpaceAgeFix](https://mods.factorio.com/mod/Load-Furn-2-SpaceAgeFix) mod), the game fails to load with an error message like this:

``` text
Failed to load mods: entity prototype "... some miniloader entity ending in -l..." (loader-1x1) collision_mask(Modifications: Miniloader (Redux)) must collide with entity prototype "... some entity ... " (loader-1x1) collision_mask(...).
```

This happens when the other mod does not declare collision with the `transport_belt` layer. The default collision mask for loaders includes this and most custom loader should simply use the default.

Starting with version 0.10.2, there is now a startup switch (`Sanitize non-Miniloader loader entities`) that tries to 'fix up' such loaders. It adds the `transport_belt` layer to the collision mask of all configured loaders.

Note that this may break functionality of those other loaders. If that is the case, the mod and Miniloader are not compatible.

If you encounter this error, try enabling this setting first. It has no permanent effect on the game; if it breaks another mod, simply uncheck it again.

To enable this setting, when the game fails to start:

- first disable the _other_ mod that causes the problem. Keep Miniloader enabled
- set the startup setting and restart the game
- re-enable the other mod
