import gdext, gdext/classes/gdSceneTree
import gdext/classes / [gdInput, gdPolygon2D, gdLabel]

type PolygonClass* {.gdsync.} = ptr object of Polygon2D

method ready(self:PolygonClass) {.gdsync.} =
  print("prints even w/PolygonClass hidden, process still runs(pres esc to exit)")

#tank controls
method process(self:PolygonClass, delta: float64) {.gdsync.} =
  if Input.isActionPressed("ui_up"): self.moveLocalY(-175.0'f64 * delta)
  elif Input.isActionPressed("ui_down"): self.moveLocalY(+155.0'f64 * delta)
  if Input.isActionPressed("ui_right"):
    self.setRotation(self.getRotation + (8.0'f64 * delta))
  elif Input.isActionPressed("ui_left"):
    self.setRotation(self.getRotation - (8.0'f64 * delta))
  if Input.isActionPressed "ui_cancel": self.getTree.quit()


type TestLabelClass* = ptr object of Label

method ready(self:TestLabelClass) {.gdsync.} =
  self.text = "\n300"
