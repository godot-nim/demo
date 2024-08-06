import gdext

# import your extension classes here
import src/main_class

# ==================================

process initialize_scene:
  # register your extension classes here
  register MainClass

  # ====================================
  #discard


GDExtensionEntryPoint name=init_library
