# godot-nim/demo

List of demo projects using godot-nim

## Projects using gdext-nim
<!-- TEMPLATES: -->
<!-- * [gdext-nim version] [yourname/yourrepo](https://path/to/your/repo): summary (optional) -->
<!-- EXAMPLES: -->
<!-- * [0.10.1] [panno8M/Dodge the Creeps 2D](https://github.com/panno8M/dodge-the-creeps-2d): A simple 2D game that to avoid creepy monsters -->
* [0.10.1] [FlanGrande/ChipNim-8](https://github.com/FlanGrande/ChipNim-8): Chip-8 Emulator

## How can I run a demo?

### Recommended

If you installed `gdext-nim` using nimble, `gdextwiz`(a CLI tool) should have been installed with it.
For example, if you want to run `demo/dodge_the_creep_2d`:

```console
USER:godot-nim/demo$ gdextwiz run dodge_the_creep_2d
wizard build-all*     Info: using /***/demo/dodge_the_creeps_2d/project.godot 
wizard build-all*     Info: build /***/demo/dodge_the_creeps_2d/nim/bootstrap.nim
wizard run*     Info: godot executable found. launching... 
```

`run` command is clever and will start the editor at the first time; after the second time, the game will be run directly.

For more details about `gdextwiz`, see the [document][1].

### Another way

```console
USER:godot-nim/demo$ nim c dodge_the_creeps_2d/nim/bootstrap.nim
USER:godot-nim/demo$ godot --editor --path dodge_the_creeps_2d
```

That's it. Have a fun!

## Contribute

godot-nim is currently seeking contributions of demo projects to help users learn how to use the library more specifically and to ensure that the library is working properly.
If you have examples of ported demos using GDScript or other languages, or applications that are small enough to consist of a few classes, please consider contributing.

See [CONTRIBUTING.md][2] for more details.

## Copyright

This repository is made possible by the contributions of many people who have contributed projects. Therefore, licensing and copyright holders vary for each demo project.

[1]: https://github.com/godot-nim/gdext-nim/wiki/gdextwiz
[2]: https://github.com/godot-nim/demo/blob/main/CONTRIBUTING.md
