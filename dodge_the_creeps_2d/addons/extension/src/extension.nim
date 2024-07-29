import gdext

import extension/player
import extension/mob
import extension/hud
import extension/main

process initialize_scene:
  register Player
  register Mob
  register Hud
  register Main

GDExtension_EntryPoint name=init_library