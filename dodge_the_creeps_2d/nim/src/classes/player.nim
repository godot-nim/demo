import gdext
import gdextgen/classes/gdArea2D
import gdextgen/classes/gdInput
import gdextgen/classes/gdSceneTree
import gdextgen/classes/gdAnimatedSprite2D
import gdextgen/classes/gdCollisionShape2D

var screen_size: Vector2

type Player* = ptr object of Area2D
  speed: float32 = 400
  AnimatedSprite2D: AnimatedSprite2D
  CollisionShape2D: CollisionShape2D

`@export`"speed",
    proc (self: Player): float32 = self.speed,
    proc (self: Player; value: float32) = self.speed = value

proc hit*(self: Player): Error {.gdsync, signal.}

proc start*(self: Player; pos: Vector2) {.gdsync.} =
  self.position = pos
  show self
  self.CollisionShape2D.disabled = false

method ready(self: Player) {.gdsync.} =
  if Engine.isEditorHint: return
  screen_size = self.getViewportRect().size
  self.AnimatedSprite2D = self/AnimatedSprite2D
  self.CollisionShape2D = self/CollisionShape2D
  discard self.connect("body_entered", self.callable("_on_body_entered"))

  hide self

method process(self: Player; delta: float64) {.gdsync.} =
  if Engine.isEditorHint: return

  var velocity: Vector2
  if Input.isActionPressed "move_right":
    velocity.*x += 1
  if Input.isActionPressed "move_left":
    velocity.*x -= 1
  if Input.isActionPressed "move_down":
    velocity.*y += 1
  if Input.isActionPressed "move_up":
    velocity.*y -= 1

  if velocity.length > 0:
    velocity = velocity.normalized * self.speed
    self.AnimatedSprite2D.play()
  else:
    self.AnimatedSprite2D.stop()

  self.position = (self.position + velocity * float32 delta)
    .clamp(Vector2.Zero, screen_size)

  if velocity.*x != 0:
    self.AnimatedSprite2D.animation = "walk"
    self.AnimatedSprite2D.flip_v = false
    self.AnimatedSprite2D.flip_h = velocity.*x < 0
  elif velocity.*y != 0:
    self.AnimatedSprite2D.animation = "up"
    self.AnimatedSprite2D.flip_v = velocity.*y > 0

proc onBodyEntered(self: Player; body: Variant) {.gdsync, name: "_on_body_entered".} =
  hide self
  discard self.hit()
  self.CollisionShape2D.setDeferred("disabled", variant true)
