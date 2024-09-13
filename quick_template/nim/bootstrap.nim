import gdext

# import your extension classes here
import my_class

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register MyClass

  # ====================================
  discard


GDExtensionEntryPoint
