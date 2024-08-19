import std/[strutils, strformat]
import gdext
import gdextgen/classes/[gdSceneTree, gdInput, gdLineEdit, gdLabel, gdBaseButton]
import gdextgen/classes/gdWindow

type
  Base {.pure.} = enum
    Bin, Dec, Hex
  State = object
    input: string
    select: Base = Dec

  MainClass* = ref object of Control
    window: Window
    in_node: LineEdit
    out_node: Label
    bases: array[Base, BaseButton]
    state: State

func or0(str: string): string {.raises: [].} =
  if str.isEmptyOrWhiteSpace: "0"
  else: str

func removeExtra0(str: string): string {.raises: [].} =
  str.strip(trailing = false, chars = {'0'})

proc myToBin(value: int): string {.raises: [].} =
  try:
    "0b" & value.toBin(63).removeExtra0.or0.insertSep(' ', 4)
  except:
    getCurrentExceptionMsg()

proc myToHex(value: int): string {.raises: [].} =
  try:
    "0x" & value.toHex.removeExtra0.or0
  except:
    getCurrentExceptionMsg()

proc myToDec(value: int): string {.raises: [].} =
  "0d" & $value

proc output(self: MainClass; text: string) =
  self.out_node.text = text

method ready(self: MainClass) {.gdsync.} =
  if Engine.isEditorHint: return

  self.window = self.getWindow()
  self.window.minSize = vector2i(325, 225)
  self.window.maxSize = vector2i(960, 480)

  self.in_node = self/"grid/inbox" as LineEdit
  self.out_node = self/"grid/a/outlabel" as Label

  self.bases = [
    self/"grid/binary_button"  as BaseButton,
    self/"grid/decimal_button" as BaseButton,
    self/"grid/hex_button"     as BaseButton, ]

  print "in signal: " & $self.in_node.connect("text_changed", self.callable "inbox_text_changed")

  let pressed = stringName "pressed"

  print "dec signal: " & $self.bases[Dec].connect(pressed, self.callable "submit_decimal")
  print "bin signal: " & $self.bases[Bin].connect(pressed, self.callable "submit_binary")
  print "hex signal: " & $self.bases[Hex].connect(pressed, self.callable "submit_hex")

  self.output "Hello from Nim-lang!"

proc `$`(state: State): string {.raises: [].} =
  try:
    case state.select
    of Dec:
      let value = state.input.or0.parseInt
      &"""
BIN: {value.myToBin}
HEX: {value.mytoHex}"""
    of Bin:
      let value = state.input.or0.parseBinInt
      &"""
DEC: {value.myToDec}
HEX: {value.myToHex}"""
    of Hex:
      let value = state.input.or0.parseHexInt
      &"""
DEC: {value.myToDec}
BIN: {value.myToBin}"""
  except:
    getCurrentExceptionMsg()

proc inbox_text_changed(self: MainClass; intext: string) {.gdsync.} =
  self.state.input = intext
  self.output $self.state

proc submit_decimal(self: MainClass) {.gdsync.} =
  self.state.select = Dec
  self.output $self.state
proc submit_binary(self: MainClass) {.gdsync.} =
  self.state.select = Bin
  self.output $self.state
proc submit_hex(self: MainClass) {.gdsync.} =
  self.state.select = Hex
  self.output $self.state
