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
