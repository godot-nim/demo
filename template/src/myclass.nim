import gdext
import gdextgen/classes/gdNode

type MyClass* = ref object of Node

proc sayHello*(self: MyClass) {.gdsync, name: "say_hello".} =
  print "hello, world!"

method ready*(self: MyClass) {.gdsync.} =
  self.sayHello()