import gdext
import gdextgen/classes / [gdLabel]

type MyClass* = ref object of Label
  #types defined here,for instance label_node:Label if class were different node type

method ready(self:MyClass) {.gdsync.} =
  if isRunningInEditor: return #running code in the editor may produce unintented scene changes, even if nodes are hidden
  self.text = "Hello from Nim-lang!" #self.label_node.text if class were different node type

