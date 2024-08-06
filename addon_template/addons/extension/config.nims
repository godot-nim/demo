import os

--app: lib
--noMain: on
--define: nimPreviewDotLikeOps

let workspaceName = projectDir().splitFile.name

switch("define", "ExtensionMain:" & workspaceName)
switch("out", "$projectdir/lib/" & workspaceName.toDll)

# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config

# ===============================================================
# Edit your workspace-local settings here

--path: src
