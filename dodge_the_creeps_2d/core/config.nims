# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config

when withDir(thisDir(), system.fileExists("bootstrapconf.nims")):
  include "bootstrapconf.nims"

# ===============================================================
# Edit your workspace-local settings here

--path: src