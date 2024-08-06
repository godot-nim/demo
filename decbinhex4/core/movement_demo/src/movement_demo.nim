import gdext, gdextgen/classes/gdSceneTree
import gdextgen/classes / [gdInput, gdPolygon2D, gdLabel]

type PolygonClass* = ref object of Polygon2D
  Input:Input
  InputMap:InputMap

method ready(self:PolygonClass) {.gdsync.} =
  if isRunningInEditor: return
  print("prints even w/PolygonClass hidden, process still runs(pres esc to exit)")
  self.Input = /Input
  self.InputMap = /InputMap

#tank controls
method process(self:PolygonClass, delta: float64) {.gdsync.} =
  if isRunningInEditor: return
  if self.Input.isActionPressed("ui_up"): self.moveLocalY(-175.0'f64 * delta)
  elif self.Input.isActionPressed("ui_down"): self.moveLocalY(+155.0'f64 * delta)
  if self.Input.isActionPressed("ui_right"):
    self.setRotation(self.getRotation + (8.0'f64 * delta))
  elif self.Input.isActionPressed("ui_left"):
    self.setRotation(self.getRotation - (8.0'f64 * delta))
  if self.Input.isActionPressed "ui_cancel": self.getTree.quit()


type TestLabelClass* = ref object of Label

process initialize_scene: register TestLabelClass

method ready(self:TestLabelClass) {.gdsync.} =
  if isRunningInEditor: return
  self.text = "\n300"
