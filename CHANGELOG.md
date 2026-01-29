Version v26.01.a
----------------

Highlights:
 - Fix resource pack on Minecraft 1.21.11

Resource Pack:
 - Improve compatible version range to 1.20 - 1.21.11 (though it works back to
   1.15)
 - Fix missing A4 textures breaking all models on 1.21.11

Saved train module:
 - Lower platforms (they changed height between 1.20 and 1.20.2)


Version v25.03.a
----------------

Highlights:
 - Fix golden pickaxe fallback model on Minecraft 1.21.4

Resource Pack:
 - Add "minecraft:" prefixes in items JSON
 - Drop damage check in items JSON


Version v25.02.a
----------------

Highlights:
 - Fix resource pack on Minecraft 1.21.4

Resource Pack:
 - Generate new & old item JSON files from custom\_models.csv
 - Update resource pack pack\_version to 46

Documentation:
 - README: Add dependencies section


Version v23.10.a
----------------

Highlights:
 - Class 158: New [GWR livery variant](docs/class158.md#variants) ("class158\_gwr")
 - Metro: New [red and yellow line variants](docs/metro.md#variants) ("metro\_red", "metro\_yellow")
 - Metro: Easy [branding customisation](docs/metro.md#customisation) on front and sides

Resource Pack:
 - Rearrange train model data codes for skinning (NOTE: this makes existing
   trains that use old resource packs incompatible with the new resource pack,
   and vice versa. Only newly spawned trains will display correctly).
 - Separate models & textures into nested directories
 - Add generation of skin model wrappers
 - Update resource pack pack\_version to 15
 - Tweak resource pack description

Saved train module:
 - Reduce wait distance to reduce lag (NOTE: this may make trains queue up
   closer to one another and cause congestion if you have missing mutex zones).
 - Prepare trains for skinning
 - Turn off collisions to reduce lag
 - Refactor saved train configuration list

[LNER Class A4](docs/a4.md) ("a4"):
 - Allow every model to be skinned

[British Rail Class 158 Express Sprinter](docs/class158.md) ("class158"):
 - Add a [GWR livery variant](docs/class158.md#variants) ("class158\_gwr")
 - Allow most models to be skinned
 - Adjust seat positions to fix exit
 - Minor UV mapping corrections
 - Fix seat up UV mapping
 - Update documentation

[Metro](docs/metro.md) ("metro"):
 - New [red and yellow line variants](docs/metro.md#variants) ("metro\_red", "metro\_yellow")
 - Easy [branding customisation](docs/metro.md#customisation) on front and sides
 - Make top blue stripe consistent
 - Allow most models to be skinned
 - Document livery variants

Documentation:
 - README: Add nice banner showing multiple trains
 - README: Add donation links
 - README: Fix typo "resouce"
 - Restructure documentation
 - Add CHANGELOG.md


Version v23.09.b
----------------

General:
 - Set GUI display transformations on all models

[LNER Class A4](docs/a4.md) ("a4"):
 - Work around wheel wobbling and yawing at speed on diagonal track
 - Fix platform heights
 - Enable spin animations in lite train module

[Metro](docs/metro.md) ("metro"):
 - Fix platform heights


Version v23.09.a
----------------

Highlights:
 - Add new train, [LNER Class A4](docs/a4.md), named "a4" (see below)
 - Reorganise item overrides to use custom-model-data instead of using
   unbreakable pickaxe damage levels (NOTE: this makes existing trains
   that use the old resource pack incompatible with the new resource
   pack, and vice versa. Only newly spawned trains will display
   correctly).
 - Add a lite version of saved train module, with fewer platforms used
   in the trains for better performance.

General:
 - Clarify install instructions in README.md
 - Include only .yml.in files instead of .yml
 - Remove unused data in nodes of type EMPTY
 - Delete empty lines in saved train module

[LNER Class A4](docs/a4.md) ("a4"):
 - Skinned as no. 4468 (Mallard) which holds the world speed record
   for steam locomotives
 - Fully articulated (leader, loco, trailer, tender)
 - External detailing mostly done
 - Minimal cab detailing, with seats and platforms to stand on
 - Smoke from the chimney (from a hidden blaze)
 - A roaring fire in the fire box (with hidden fire balls)
 - Animated wheels (but they may go a bit crazy when fast on diagonal
   track)
 - Partially animated wheel mechanics


Version v23.04.a
----------------

General:
 - Reduce size of file paths

[Metro train](docs/metro.md):
 - Make bendy connection symmetrical
 - Add seating and holds


Version v23.02.a
----------------

Initial release of HoganFam TC Train Pack.
