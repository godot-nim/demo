import gdext
import gdext/classes/[
  gdLabel,
  ]

type MyClass* {.gdsync.} = ptr object of Label
  #types defined here,for instance label_node:Label if class were different node type

method ready(self:MyClass) {.gdsync.} =
  self.text = "Hello from Nim-lang!" #self.label_node.text if class were different node type

