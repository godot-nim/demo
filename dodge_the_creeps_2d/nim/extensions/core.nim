import gdext

# import your extension classes here
# import myclass
import dtc2d/classes/player
import dtc2d/classes/mob
import dtc2d/classes/hud
import dtc2d/classes/main
# ==================================

process initialize_scene:
  # register your extension classes here
  # register MyClass
  register Player
  register Mob
  register Hud
  register Main
  # ====================================
  discard


GDExtensionEntryPoint name=init_library