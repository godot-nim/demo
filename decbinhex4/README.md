# decbinhex

![.README/decbinhex4_preview]

A number converter program, updated to Godot 4. Available functionality depends on text entered. Has limited live-conversion available.

How to run: Compile with `nim c bootstrap` in the core folder. (I use this command in my editor to compile from any src file: `cd ../ && nim c bootstrap`)

Extras:

- A polygon with basic movement (unhide Polygon class, arrows/wasd). Build this in the movement_demo folder, same command. Then unhide the node.
- Minimum and maximum window size
- A simple benchmark (I'm not sure what it actually correlates to, but uncomment the last line in method ready of main_class.nim)
- An alternate main class by panno8M in README folder. Cleaner and more advanced.

Compare to the code of the 3.X version originally contributed to the zetashift's repo: https://github.com/zetashift/godotnim-samples/tree/master/decbinhex
