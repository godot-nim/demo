import gdext, gdextgen/classes/gdSceneTree
import gdextgen/classes / [gdInput, gdPolygon2D]

type PolygonClass* = ref object of Polygon2D
  Input:Input
  InputMap:InputMap

method ready*(self:PolygonClass) {.gdsync.} =
  if isRunningInEditor: return
  print("this will print even if the class is hidden, and esc will still exit")
  self.Input = /Input
  self.InputMap = /InputMap

#tank movement
method process*(self:PolygonClass, delta: float64) {.gdsync.} =
  if isRunningInEditor: return
  if self.Input.isActionPressed("ui_up"): self.moveLocalY(-175.0'f64 * delta)
  elif self.Input.isActionPressed("ui_down"): self.moveLocalY(+155.0'f64 * delta)
  if self.Input.isActionPressed("ui_right"): self.setRotation(self.getRotation + (8.0'f64 * delta))
  elif self.Input.isActionPressed("ui_left"): self.setRotation(self.getRotation - (8.0'f64 * delta))
  if self.Input.isActionPressed "ui_cancel": self.getTree.quit()
