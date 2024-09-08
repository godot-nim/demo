import gdext

# import your extension classes here
# import myclass
import classes/player
import classes/mob
import classes/hud
import classes/main
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


GDExtensionEntryPoint