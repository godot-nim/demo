# decbinhex4

![](readme/decbinhex4_preview.png)

A number converter program, updated to Godot 4. Available functionality depends on text entered. Has limited live-conversion available.

How to run: Compile with `nim c bootstrap` in the core folder. (I use this command in my editor to compile from any src file: `nim c ../bootstrap`)

Extras:

- A polygon with basic movement. Build this in the movement_demo folder, same command. Then unhide the node, arrows/wasd.
- Minimum and maximum window size
- A simple benchmark (I'm not sure what it actually correlates to, but uncomment the last line in method ready of main_class.nim)
- An alternate main class by panno8M in readme folder. Cleaner and more advanced.

Compare to the code of the 3.X bindings version originally contributed here: https://github.com/zetashift/godotnim-samples/tree/master/decbinhex

Known annoyance, not code-related: The GUI being able to shift size means that the window looks slightly off when scaled to the smallest size when displaying a result. The old version was smaller by default and did not have that issue.
