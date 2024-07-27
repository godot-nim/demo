# Package

version       = "0.1.0"
author        = "godot-nim, la.panon."
description   = "Blank project template for quick start"
license       = "MIT"
srcDir        = "src"
bin           = @["myextension"]
binDir        = "lib"


# Dependencies

requires "nim >= 2.0.0"

requires "godotcore"
requires "godotgen"
requires "godot"