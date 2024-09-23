import gdext

import gdext/classes/gdSceneTree
import gdext/classes/gdLabel
# import gdext/classes/gdButton
import gdext/classes/gdTimer
import gdext/classes/gdInput

type Hud* = ptr object of CanvasLayer
  ScoreLabel*: Label
  Message*: Label
  StartButton*: Button

  GameOverTimer*: Timer
  GetReadyTimer*: Timer
  StartButtonTimer*: Timer

  playing: Bool

proc start_game*(self: Hud): Error {.gdsync, signal.}

proc show_message*(self: Hud; text: String) {.gdsync.} =
  self.Message.text = text
  show self.Message

proc update_score*(self: Hud; score: int) {.gdsync.} =
  self.ScoreLabel.text = $score

proc show_get_ready*(self: Hud) {.gdsync.} =
  self.show_message "Get Ready"
  start self.GetReadyTimer

proc show_game_over*(self: Hud) {.gdsync.} =
  self.show_message "Game Over"
  start self.GameOverTimer
  self.playing = false

proc on_GameOverTimer_timeout*(self: Hud) {.gdsync, name: "_on_game_over_timer_timeout".} =
  self.show_message "Dodge the Creeps!"
  start self.StartButtonTimer

proc on_GetReadyTimer_timeout*(self: Hud) {.gdsync, name: "_on_get_ready_timer_timeout".} =
  hide self.Message
  self.playing = true

proc on_StartButtonTimer_timeout*(self: Hud) {.gdsync, name: "_on_start_button_timer_timeout".} =
  show self.StartButton

proc on_StartButton_pressed*(self: Hud) {.gdsync, name: "_on_start_button_pressed".} =
  hide self.StartButton
  discard self.start_game()


method ready*(self: Hud) {.gdsync.} =
  if Engine.isEditorHint: return
  self.ScoreLabel = self/"ScoreLabel" as Label
  self.Message = self/"Message" as Label
  self.StartButton = self/"StartButton" as Button

  self.GameOverTimer = self/"GameOverTimer" as Timer
  self.GetReadyTimer = self/"GetReadyTimer" as Timer
  self.StartButtonTimer = self/"StartButtonTimer" as Timer

  discard self.GameOverTimer.connect("timeout", self.callable("_on_game_over_timer_timeout"))
  discard self.GetReadyTimer.connect("timeout", self.callable( "_on_get_ready_timer_timeout"))
  discard self.StartButtonTimer.connect("timeout", self.callable( "_on_start_button_timer_timeout"))
  discard self.StartButton.connect("pressed", self.callable( "_on_start_button_pressed"))

method process(self: Hud; delta: float64) {.gdsync.} =
  if Engine.isEditorHint: return

  if Input.isActionPressed "ui_cancel": self.getTree.quit()
  if not self.playing: return #no pausing in menu/ready_timer, which have their own message text
  self.Message.text = "Paused"
  if Input.isActionJustPressed "pause_game": #Just avoids flickering pause
    self.get_tree().paused = not self.get_tree().paused #inverts
    self.Message.visible = not self.Message.visible
  #if self.get_tree().paused: return #for later process code that should not run when paused
