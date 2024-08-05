import gdext

# import your extension classes here
import src/movement_demo

# ==================================

process initialize_scene:
  # register your extension classes here
  register PolygonClass

  # ====================================
  #discard


GDExtensionEntryPoint name=init_library
