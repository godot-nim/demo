import std/random

import gdext

import gdPlayer
import gdMob
import gdHud

import gdextgen/classes/gdSceneTree
import gdextgen/classes/gdNode
import gdextgen/classes/gdMarker2D
import gdextgen/classes/gdTimer
import gdextgen/classes/gdPackedScene
import gdextgen/classes/gdPathFollow2D
import gdextgen/classes/gdRigidBody2D
import gdextgen/classes/gdAudioStreamPlayer

type Main* = ref object of Node
  mob_scene {.getter: "get_mob_scene", setter: "set_mob_scene".} : gdref PackedScene
  score: int
  Player: Player
  MobTimer: Timer
  ScoreTimer: Timer
  StartTimer: Timer
  StartPosition: Marker2D
  MobSpawnLocation: PathFollow2D
  Hud: Hud
  Music: AudioStreamPlayer
  DeathSound: AudioStreamPlayer

proc `mob_scene=`(self: Main; value: gdref PackedScene) {.gdsync, name: "set_mob_scene".} =
  self.mob_scene = value
proc mob_scene(self: Main): gdref PackedScene {.gdsync, name: "get_mob_scene".} =
  self.mob_scene

proc new_game(self: Main) {.gdsync.} =
  self.score = 0
  self.Player.start(self.StartPosition.position)
  start self.StartTimer
  play self.Music
  self.Hud.update_score(self.score)
  self.Hud.show_get_ready()
  self.getTree.callGroup("mobs", "queue_free")

proc game_over(self: Main) {.gdsync.} =
  stop self.ScoreTimer
  stop self.MobTimer
  stop self.Music
  play self.DeathSound
  self.Hud.show_game_over()

method ready(self: Main) {.gdsync.} =
  if isRunningInEditor: return
  self.Player = self/Player
  self.Hud = self/Hud
  self.MobTimer = self/"MobTimer" as Timer
  self.ScoreTimer = self/"ScoreTimer" as Timer
  self.StartTimer = self/"StartTimer" as Timer
  self.StartPosition = self/"StartPosition" as Marker2D
  self.MobSpawnLocation = self/"MobPath"/"MobSpawnLocation" as PathFollow2D
  self.Music = self/"Music" as AudioStreamPlayer
  self.DeathSound = self/"DeathSound" as AudioStreamPlayer

  discard self.Player.connect("hit", self.callable "game_over")
  discard self.Hud.connect("start_game", self.callable "new_game")

  discard self.MobTimer.connect("timeout", self.callable "_on_mob_timer_timeout")
  discard self.ScoreTimer.connect("timeout", self.callable "_on_score_timer_timeout")
  discard self.StartTimer.connect("timeout", self.callable "_on_start_timer_timeout")


proc on_ScoreTimer_timeout(self: Main) {.gdsync, name: "_on_score_timer_timeout".} =
  inc self.score
  self.Hud.update_score self.score

proc on_StartTimer_timeout(self: Main) {.gdsync, name: "_on_start_timer_timeout".} =
  start self.MobTimer
  start self.ScoreTimer

proc on_MobTimer_timeout(self: Main) {.gdsync, name: "_on_mob_timer_timeout".} =
  let mob = self.mob_scene.instantiate as Mob
  self.MobSpawnLocation.progressRatio = rand(1f)

  var direction = self.MobSpawnLocation.rotation + PI/2

  mob.position = self.MobSpawnLocation.position

  direction += rand(-PI/4 .. PI/4)
  mob.rotation = direction

  var velocity = vector(rand(150f .. 250f), 0f)
  mob.linearVelocity = velocity.rotated(direction)

  self.add_child mob