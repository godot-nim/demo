import gdext

import gdext/classes/gdCanvasLayer
import gdext/classes/gdSceneTree
import gdext/classes/gdLabel
import gdext/classes/gdButton
import gdext/classes/gdTimer
import gdext/classes/gdInput

type Hud* {.gdsync.} = ptr object of CanvasLayer
  ScoreLabel: Label
  Message: Label
  StartButton: Button
  MessageTimer: Timer

proc startGame*(self: Hud): Error {.gdsync, signal, name: "start_game".}

proc showMessage*(self: Hud; text: String) =
  self.Message.text = text
  show self.Message
  start self.MessageTimer

proc updateScore*(self: Hud; score: int) =
  self.ScoreLabel.text = $score

proc showGetReady*(self: Hud) =
  self.showMessage "Get Ready"

proc showGameOver*(self: Hud) =
  self.showMessage "Game Over"

  discard self.MessageTimer.connect("timeout", self.callable"_on_game_over_timer_timeout")
  proc onGameOverTimerTimeout(self: Hud) {.gdsync, name: "_on_game_over_timer_timeout".} =
    self.MessageTimer.disconnect("timeout", self.callable"_on_game_over_timer_timeout")
    self.Message.text = "Dodge the Creeps!"
    show self.Message
    discard self.getTree.createTimer(1)[].connect("timeout", self.callable"_on_start_button_timer_timeout")

  proc onStartButtonTimerTimeout(self: Hud) {.gdsync, name: "_on_start_button_timer_timeout".} =
    show self.StartButton

proc onMessageTimerTimeout(self: Hud) {.gdsync, name: "_on_message_timer_timeout".} =
  hide self.Message

proc onStartButtonPressed(self: Hud) {.gdsync, name: "_on_start_button_pressed".} =
  hide self.StartButton
  discard self.startGame()

method ready*(self: Hud) {.gdsync.} =
  self.ScoreLabel = self/"ScoreLabel" as Label
  self.Message = self/"Message" as Label
  self.StartButton = self/"StartButton" as Button
  self.MessageTimer = self/"MessageTimer" as Timer

  discard self.MessageTimer.connect("timeout", self.callable("_on_message_timer_timeout"))
  discard self.StartButton.connect("pressed", self.callable( "_on_start_button_pressed"))
