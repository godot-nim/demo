# Package

version       = "1.0.0"
author        = "insomniac_lemon"
description   = "A simple number converter program using Nim-lang and Godot, recreated for Godot 4. Compare code to the original decbinhex on Zetashift's example repo."
license       = "MIT"
srcDir        = "src"
bin           = @["decbinhex4"]
binDir        = "lib"


# Dependencies

requires "nim >= 2.0.0"

requires "gdextcore"
requires "gdextgen"
requires "gdext"
