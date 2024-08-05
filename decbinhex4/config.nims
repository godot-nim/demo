## This is applied to all workspaces below it, thus applies to both extensions.
import os

--app: lib
--noMain: on
--define: nimPreviewDotLikeOps

let workspaceName = projectDir().splitFile.name

switch("define", "projectName:" & workspaceName)
switch("out", "$projectdir/lib"/workspaceName.toDll)

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
