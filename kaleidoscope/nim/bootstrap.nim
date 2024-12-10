import gdext

# import your extension classes here
import kaleidoscope_class

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register KaleidoscopeClass

  # ====================================
  discard


GDExtensionEntryPoint
