import gdext

import classes/gdPlayer
import classes/gdMob
import classes/gdHud

import gdext/classes/gdSceneTree
import gdext/classes/gdNode
import gdext/classes/gdMarker2D
import gdext/classes/gdTimer
import gdext/classes/gdPackedScene
import gdext/classes/gdPathFollow2D
import gdext/classes/gdRigidBody2D
import gdext/classes/gdAudioStreamPlayer

type Main* {.gdsync.} = ptr object of Node
  mob_scene* {.gdexport.}: gdref PackedScene
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

proc newGame(self: Main) {.gdsync, name: "new_game".} =
  self.score = 0
  self.Player.start(self.StartPosition.position)
  start self.StartTimer
  play self.Music
  self.Hud.updateScore(self.score)
  self.Hud.showGetReady()
  self.getTree.callGroup("mobs", "queue_free")

proc gameOver(self: Main) {.gdsync, name: "game_over".} =
  stop self.ScoreTimer
  stop self.MobTimer
  stop self.Music
  play self.DeathSound
  self.Hud.showGameOver()

method ready(self: Main) {.gdsync.} =
  self.Player = self/"Player" as Player
  self.Hud = self/"Hud" as Hud
  self.MobTimer = self/"MobTimer" as Timer
  self.ScoreTimer = self/"ScoreTimer" as Timer
  self.StartTimer = self/"StartTimer" as Timer
  self.StartPosition = self/"StartPosition" as Marker2D
  self.MobSpawnLocation = self/"MobPath"/"MobSpawnLocation" as PathFollow2D
  self.Music = self/"Music" as AudioStreamPlayer
  self.DeathSound = self/"DeathSound" as AudioStreamPlayer

  discard self.Player.connect("hit", self.callable"game_over")
  discard self.Hud.connect("start_game", self.callable"new_game")

  discard self.MobTimer.connect("timeout", self.callable"_on_mob_timer_timeout")
  discard self.ScoreTimer.connect("timeout", self.callable"_on_score_timer_timeout")
  discard self.StartTimer.connect("timeout", self.callable"_on_start_timer_timeout")


proc onScoreTimerTimeout(self: Main) {.gdsync, name: "_on_score_timer_timeout".} =
  inc self.score
  self.Hud.updateScore(self.score)

proc onStartTimerTimeout(self: Main) {.gdsync, name: "_on_start_timer_timeout".} =
  start self.MobTimer
  start self.ScoreTimer

proc onMobTimerTimeout(self: Main) {.gdsync, name: "_on_mob_timer_timeout".} =
  let mob = self.mob_scene[].instantiate as Mob
  self.MobSpawnLocation.progressRatio = randfRange(0, 1)

  var direction = self.MobSpawnLocation.rotation + PI/2

  mob.position = self.MobSpawnLocation.position

  direction += randfRange(-PI/4, PI/4)

  mob.rotation = direction

  var velocity = vector(randfRange(150, 250), 0f)
  mob.linearVelocity = velocity.rotated(direction)

  self.add_child mob