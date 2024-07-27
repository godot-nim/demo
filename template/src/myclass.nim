import godot
import godotgen/classes/gdNode

type MyClass* = ref object of Node

proc sayHello*(self: MyClass) {.gdsync, name: "say_hello".} =
  godot.echo "hello, world!"

method ready*(self: MyClass) {.gdsync.} =
  self.sayHello()