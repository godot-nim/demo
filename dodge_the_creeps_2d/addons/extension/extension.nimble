# Package

version       = "0.1.0"
author        = "la .panon."
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["extension"]
binDir        = "lib"


# Dependencies

requires "nim >= 2.0.0"

requires "gdextcore"
requires "gdextgen"
requires "gdext"