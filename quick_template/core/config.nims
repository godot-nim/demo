# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config

# begin gdext spacification
when withDir(thisDir(), system.fileExists("bootstrapconf.nims")):
  include "bootstrapconf.nims"
# end gdext spacification

# ===============================================================
# Edit your workspace-local settings here

--path: src
