import std/random

import godot
import godotgen/classes/gdAnimatedSprite2D
import godotgen/classes/gdSpriteFrames
import godotgen/classes/gdSceneTree

type Mob* = ref object of RigidBody2D
  AnimatedSprite2D: AnimatedSprite2D
  VisibleOnScreenNotifier2D: VisibleOnScreenNotifier2D

method ready(self: Mob) {.gdsync.} =
  if self.getTree.editedSceneRoot != nil: return
  echo "Mob::ready"
  self.AnimatedSprite2D = self/"AnimatedSprite2D" as godot.AnimatedSprite2D
  self.VisibleOnScreenNotifier2D = self/"VisibleOnScreenNotifier2D" as godot.VisibleOnScreenNotifier2D
  discard self.VisibleOnScreenNotifier2D.connect("screen_exited", self.callable("_on_visible_on_screen_notifier_2d_screen_exited"))

  let mobTypes = self.AnimatedSprite2D.spriteFrames.getAnimationNames
  self.AnimatedSprite2D.play(stringname mobTypes[rand(mobTypes.size.pred)])

proc on_VisibleOnScreenNotifier2D_screen_exited(self: Mob) {.gdsync, name: "_on_visible_on_screen_notifier_2d_screen_exited".} =
  queueFree self
