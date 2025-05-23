# "Dodge the Creeps! 2D" with godot-nim

**Author(s):**: [la.panon.](https://github.com/panno8M)

<img align="right" src="art/dtc2d_preview.png" alt="A small and lonely creature trying its best to survive by avoiding a sea of other strange creatures."/>

This is a “reinventing the wheel” of [Your first 2D game][1] using gdext. That document contains the full implementation of the GDScript version. It will be easier to understand if you read it in comparison.

Back again, demonstrating the following concepts:
- Node and scene structure
- Instancing scenes
- Input
- Signals
- UI
- Sounds

Compile with `gdextwiz build`. After this, the editor will have an error on first open (gdextension limitation), close the editor and open it again and it should work. You may still need to switch to 2D tab to see the scene (not needed to run project).

Game controls: Arrows/WASD for movement. Space bar or p-key for pause during gameplay. Esc to exit.

## Copying

`art/House In a Forest Loop.ogg` Copyright &copy; 2012 [HorrorPen](https://opengameart.org/users/horrorpen), [CC-BY 3.0: Attribution](http://creativecommons.org/licenses/by/3.0/). 
<br/>Source: https://opengameart.org/content/loop-house-in-a-forest

Images are from "Abstract Platformer". Created in 2016 by kenney.nl, [CC0 1.0 Universal](http://creativecommons.org/publicdomain/zero/1.0/). <br/>Source: https://www.kenney.nl/assets/abstract-platformer

Font is "Xolonium". Copyright &copy; 2011-2016 Severin Meyer <sev.ch@web.de>, <br/>with Reserved Font Name Xolonium, SIL open font license version 1.1. Details are in `fonts/LICENSE.txt`.

[1]: https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html
