import random

import gdext
import gdext/classes/gdNode2D
import gdext/classes/gdImage
import gdext/classes/gdTexture2D
import gdext/classes/gdResourceLoader


type
  recttwo = object
    x: int
    y: int
    width: int
    height: int


type KaleidoscopeClass* = ptr object of Node2D
  texture1: gdref Texture2D # the picture
  slices: seq[recttwo] # random cuts
  slice_count: int # number mirrors
  counter: int


proc generateSlices(self: KaleidoscopeClass) =
  let textureSize = self.texture1.unwrapped.getSize()
  for _ in 0 ..< self.slice_count:
    let x = rand(textureSize.x.int - 50)
    let y = rand(textureSize.y.int - 50)
    let width = rand(30..100)
    let height = rand(30..100)
    var r: recttwo
    r.x = x
    r.y = y
    r.width = width
    r.height = height
    self.slices.add(r)


method ready(self:KaleidoscopeClass) {.gdsync.} =
  if Engine.isEditorHint: return
  random.randomize()
  self.texture1 = ResourceLoader.load("res://resources/xmasmarket.jpg") as gdref Texture2D
  self.slice_count = 6
  self.generateSlices()
  
  

method draw(self: KaleidoscopeClass) {.gdsync.} =
  let center = self.getViewportRect.size / 2.0
  let centervector = vector2(center.x, center.y)
  let angleStep = 360.0 / self.slice_count.float64

  for i, slice in self.slices:
    let texRect = slice
    let slpos = vector2(slice.x.float, slice.y.float)
    let slsize = vector2(slice.width.float, slice.height.float)
    let texRegion = rect2(slpos, slsize)
    let texCenter = slsize / i
    for j in 0 ..< self.slice_count:
      let rotation = angleStep * j.float64
      self.drawSetTransform(centervector, degToRad(rotation), vector2(3, 3))
      self.drawTextureRectRegion(
        texture=self.texture1,
        rect=rect2(-texCenter, slsize),
        srcRect=texRegion,
        modulate = color(1, 1, 1, 1),
        transpose=j mod 2 == 1
      )


method process(self: KaleidoscopeClass, delta: float64) {.gdsync.} =
  if Engine.isEditorHint: return
  self.counter += 1
  if self.counter > 20:
    self.generateSlices()
    self.queue_redraw()
    self.counter = 0
