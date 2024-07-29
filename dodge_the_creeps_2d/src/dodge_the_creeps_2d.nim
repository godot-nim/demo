import gdext

import gdPlayer
import gdMob
import gdHud
import gdMain

process initialize_scene:
  register Player
  register Mob
  register Hud
  register Main

GDExtension_EntryPoint name=init_library