# godot-nim/demo

List of demo projects using godot-nim

## Set up

### 1. install [minister](https://github.com/godot-nim/minister) that is an assistant to develop Godot&Nim game

```bash
nimble install https://github.com/godot-nim/minister
```

### 2. run `minister install` to build & install whole godot library

In this section, following modules are installed:

* [godot-nim/coronation](https://github.com/godot-nim/coronation)
* [godot-nim/godotcore](https://github.com/godot-nim/godotcore)
* godotgen - built by coronation
* [godot-nim/godot](https://github.com/godot-nim/godot)

run `minister uninstall` enables to uninstall all above.

### 3. go to the directory that you interested in and run `nimble build`

> **( ! ) Rquired for first time**
>
> ### 4. setup godot's project files
>
> run `godot --editor` to create the project data (**.godot/**).
>
> At this point, an error message stating that initialization of the extension has failed will be output. This is a bug, but not a problem. Reloading or closing the project will resolve it.

### 5. press `F5` while godot editor or run `godot` to play the demo!