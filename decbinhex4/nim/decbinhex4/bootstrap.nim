import gdext

# import your extension classes here
import main_class

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register MainClass

  # ====================================
  #discard


GDExtensionEntryPoint
