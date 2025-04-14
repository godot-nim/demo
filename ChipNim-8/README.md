# Chip'N'im-8: A Chip-8 Emulator in Nim for Godot

Chip'N'im-8 (pronounced Chip 'N' Nim 8) is a Chip-8 emulator implemented in Nim and integrated with Godot Engine.

## Features

- Complete Chip-8 instruction set emulation
- Godot-powered UI for ROM selection and debugging
- Real-time visualization of emulator state

## Demo (Click image to go to Youtube)

[![Chip'N'im-8 in action](https://img.youtube.com/vi/PKBQE-y-lE0/0.jpg)](https://youtu.be/PKBQE-y-lE0)

## Getting Started

### ROMs

You will need roms which I added as submodules from:
https://github.com/kripod/chip8-roms/tree/master

Store it in /roms

You should run this too:
`git submodule update --init`

### Building and Running

1. Ensure you have Nim, Godot 4.x and gdext-nim 0.10.1 installed.
2. Clone this repository
3. Check https://github.com/godot-nim/gdext-nim for instructions.

## Architecture

The project uses godot-nim, a GDExtension bridge between Godot Engine and Nim. The emulator core is written in Nim, and Godot Engine is used as a sort of UI framework for displaying the emulator's state.

## License

GPL-3.0

## Note

I have to add that if you are using Nim and are struggling to find a UI library, Godot Engine + gdext-nim is the PERFECT choice compared to other alternatives out there. It's the option I found to be more future proof in terms of development. I can't overstate how happy I was to find gdext-nim after hours searching for UIs. It truly seems underrated and it felt too hard to find.

The quality of the bindings are superb with a great documentation that has the same style as Nim's + it matches GDScript classes and logic perfectly.

Thanks to la.panon for all the help during the contribution process.