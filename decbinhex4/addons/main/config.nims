switch("define", "projectName:" & projectName())
--app: "lib"
--noMain: "on"
--define: "nimPreviewDotLikeOps"
#--define: "EnableDebugEvent:on"
#--define: "EnableDebugInterface:on"
#--cc: "clang" #may be slightly faster than gcc
#--opt: "size" #for a bit more performance, slower compile
--mm:orc
# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config
