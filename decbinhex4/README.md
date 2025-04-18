# decbinhex4

**Author(s):** [insomniac_lemon](https://github.com/insomniacUNDERSCORElemon)

<img align="right" src="readme/decbinhex4_preview.png" alt="A screenshot of the demo program. A text input reads 111A, 2 options are greyed out while one has been clicked: Convert from hexadecimal. A result box at the bottom says... Decimal is: 4378. There is also a binary result but I am sure you believe me."/>

A number converter program, updated to Godot 4. Available functionality depends on text entered. Has limited live-conversion available.

How to run: Compile with `gdextwiz build` in the dir where `project.godot` is located. <!--(I use this command in my editor to compile from any src file: `nim c ../bootstrap`)-->

Extras:

- A polygon with basic movement. Build this in the movement_demo folder, same command. Then unhide the node, arrows/wasd.
- Minimum and maximum window size
- A simple benchmark (I'm not sure what it actually correlates to, but uncomment the last line in method ready of main_class.nim)
- An alternate main class by panno8M in readme folder. Cleaner and more advanced.

Compare to the code of the 3.X bindings version originally contributed here: https://github.com/zetashift/godotnim-samples/tree/master/decbinhex

Known annoyance, not code-related: The GUI being able to shift size means that the window looks slightly off when scaled to the smallest size when displaying a result. The old version was smaller by default and did not have that issue.
