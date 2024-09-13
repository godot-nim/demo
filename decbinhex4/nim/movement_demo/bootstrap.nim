import gdext

# import your extension classes here
import movement_demo

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register PolygonClass

  # ====================================
  #discard


GDExtensionEntryPoint
