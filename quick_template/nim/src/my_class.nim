import gdext
import gdext/classes / [gdLabel]

type MyClass* = ptr object of Label
  #types defined here,for instance label_node:Label if class were different node type

method ready(self:MyClass) {.gdsync.} =
  if Engine.isEditorHint: return #running code in the editor may produce unintented scene changes, even if nodes are hidden
  self.text = "Hello from Nim-lang!" #self.label_node.text if class were different node type

