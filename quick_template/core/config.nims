## This file can also be placed at scene root to act as the default for all workspaces
import os

--app: lib
--noMain: on
--define: nimPreviewDotLikeOps

let workspaceName = projectDir().splitFile.name

switch("define", "ExtensionName:" & workspaceName)
switch("out", "$projectdir/lib/" & workspaceName.toDll)

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
