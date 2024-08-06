## This file was copied from https://github.com/godot-nim/gdextwiz/blob/main/src/gdextwizpkg/subcommands/workspace/template
## This file is used to build the extension.
## Basically, there is no need to edit.
import os

--app: lib
--noMain: on
--define: nimPreviewDotLikeOps

let workspaceName = projectDir().splitFile.name

switch("define", "ExtensionMain:" & workspaceName)
switch("out", "$projectdir/lib/" & workspaceName.toDll)
