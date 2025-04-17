import gdext
import gdext/classes/gdAnimatedSprite2D
import gdext/classes/gdSpriteFrames
import gdext/classes/gdSceneTree

type Mob* {.gdsync.} = ptr object of RigidBody2D

method ready(self: Mob) {.gdsync.} =
  let AnimatedSprite2D = self/"AnimatedSprite2D" as AnimatedSprite2D
  let VisibleOnScreenNotifier2D = self/"VisibleOnScreenNotifier2D" as VisibleOnScreenNotifier2D

  discard VisibleOnScreenNotifier2D.connect("screen_exited", self.callable"_on_visible_on_screen_notifier_2d_screen_exited")

  let mobTypes = newArray AnimatedSprite2D.spriteFrames[].getAnimationNames
  AnimatedSprite2D.play(mobTypes.pickRandom.get(StringName))

proc on_VisibleOnScreenNotifier2D_screen_exited(self: Mob) {.gdsync, name: "_on_visible_on_screen_notifier_2d_screen_exited".} =
  queueFree self
