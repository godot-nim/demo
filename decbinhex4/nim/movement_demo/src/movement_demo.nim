import gdext, gdextgen/classes/gdSceneTree
import gdextgen/classes / [gdInput, gdPolygon2D, gdLabel]

type PolygonClass* = ptr object of Polygon2D

method ready(self:PolygonClass) {.gdsync.} =
  if Engine.isEditorHint: return
  print("prints even w/PolygonClass hidden, process still runs(pres esc to exit)")

#tank controls
method process(self:PolygonClass, delta: float64) {.gdsync.} =
  if Engine.isEditorHint: return
  if Input.isActionPressed("ui_up"): self.moveLocalY(-175.0'f64 * delta)
  elif Input.isActionPressed("ui_down"): self.moveLocalY(+155.0'f64 * delta)
  if Input.isActionPressed("ui_right"):
    self.setRotation(self.getRotation + (8.0'f64 * delta))
  elif Input.isActionPressed("ui_left"):
    self.setRotation(self.getRotation - (8.0'f64 * delta))
  if Input.isActionPressed "ui_cancel": self.getTree.quit()


type TestLabelClass* = ptr object of Label

method ready(self:TestLabelClass) {.gdsync.} =
  if Engine.isEditorHint: return
  self.text = "\n300"

proc register_classes {.execon: initialize_scene.} =
  register TestLabelClass
