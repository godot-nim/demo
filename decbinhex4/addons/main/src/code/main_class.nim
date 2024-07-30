import gdext, gdextgen/classes/gdSceneTree, strutils, convert#convert.nim
import gdextgen/classes / [gdInput, gdLineEdit, gdBaseButton, gdLabel]
import gdextgen/classes / [gdWindow, gdTime]

let
  hex_letters:set[char] = HexDigits - Digits
  nonhex_chars:set[char] = AllChars - HexDigits
  nonbinary_numbers:set[char] = Digits - {'0', '1'}
  dec_node:string = "grid/decimal_button"
  bin_node:string = "grid/binary_button"
  hex_node:string = "grid/hex_button"
  in_node:string = "grid/inbox"
  out_node:string = "grid/a/outlabel"


type MainClass* = ref object of Control
  window:Window

method ready(self: MainClass) {.gdsync.} =
  if isRunningInEditor: return

  self.window = self.getWindow()
  self.window.minSize = vector2i(325, 225)
  self.window.maxSize = vector2i(960, 480)

  discard self.getNode(in_node).connect("text_changed", self.callable "inbox_text_changed")
  discard self.getNode(dec_node).connect("pressed", self.callable "submit_decimal")
  discard self.getNode(bin_node).connect("pressed", self.callable "submit_binary")
  discard self.getNode(hex_node).connect("pressed", self.callable "submit_hex")
  self.getNode(out_node).castTo(Label).text = "Hello from Nim-lang!"
  print("All ready!")
  #print(benchmark()) #benchmark from convert.nim

proc disable_all_buttons(self: MainClass, message:string) =
  self.getNode(dec_node).castTo(BaseButton).disabled = true
  self.getNode(bin_node).castTo(BaseButton).disabled = true
  self.getNode(hex_node).castTo(BaseButton).disabled = true
  self.getNode(out_node).castTo(Label).text = message


proc inbox_text_changed(self: MainClass, intext:string) {.gdsync.} =
  #print intext.len
  if nonhex_chars in intext or intext.len == 0:
    #Important! any proc called that also needs to deal with nodes will error if not called with self
    #(or self as a parameter, but that looks odd since it's not+cannot be defined as an argument)
    self.disable_all_buttons("Waiting for valid input.")
    return
  if intext.len > 63:
    self.disable_all_buttons("Input too large, causes overflow!")
    return
  self.getNode(out_node).castTo(Label).text = "Waiting for button choice."
  self.getNode(hex_node).castTo(BaseButton).disabled = false
  if intext.len > 15:
    self.getNode(hex_node).castTo(BaseButton).disabled = true
    if hex_letters in intext:
      self.getNode(dec_node).castTo(BaseButton).disabled = true
      self.getNode(bin_node).castTo(BaseButton).disabled = true
      self.getNode(out_node).castTo(Label).text = "Input hexadecimal too large, causes overflow!" #toHex limitation
      return
  if hex_letters in intext:
    self.getNode(dec_node).castTo(BaseButton).disabled = true
    self.getNode(bin_node).castTo(BaseButton).disabled = true
    self.getNode(out_node).castTo(Label).text = ("Live hexadecimal conversion is:\n" & $intext.parseHexInt & " in decimal")
    return
  if intext.len < 20 and parseInt(intext) == 0:
    self.disable_all_buttons("Waiting for valid input. 0.")
    return
  if intext.len >= 20: #this wasn needed in the old version, too
    self.getNode(dec_node).castTo(BaseButton).disabled = true
    if nonbinary_numbers in intext: self.getNode(out_node).castTo(Label).text = "Input decimal too large, causes overflow!"
    return
  if nonbinary_numbers in intext:
    self.getNode(bin_node).castTo(BaseButton).disabled = true
    self.getNode(dec_node).castTo(BaseButton).disabled = false
  else:
    self.getNode(bin_node).castTo(BaseButton).disabled = false
    self.getNode(dec_node).castTo(BaseButton).disabled = false
    if (self.getNode("grid/binary_check").castTo(BaseButton)).is_pressed:
      if intext.len < 20: self.getNode(out_node).castTo(Label).text = ("Live binary conversion is:\n" & $intext.parseBinInt & " in decimal")
      else: self.getNode(out_node).castTo(Label).text = ("Input decimal too large to parse for live convert, please use button")

proc submit_decimal(self: MainClass) {.gdsync.} =
  self.getNode(out_node).castTo(Label).text = convert_from_decimal($self.getNode(in_node).castTo(LineEdit).text)

proc submit_binary(self: MainClass) {.gdSync.} =
  self.getNode(out_node).castTo(Label).text = convert_from_binary($self.getNode(in_node).castTo(LineEdit).text)

proc submit_hex(self: MainClass) {.gdSync.} =
  self.getNode(out_node).castTo(Label).text = convert_from_hexadecimal($self.getNode(in_node).castTo(LineEdit).text)
