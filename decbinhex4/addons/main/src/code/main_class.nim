import strutils, convert #convert.nim
import gdext, gdextgen/classes / [gdSceneTree, gdInput, gdLineEdit, gdLabel, gdBaseButton], gdextgen/classes / [gdWindow]

const (hex_letters, nonhex_chars, nonbinary_numbers) = (HexDigits - Digits, AllChars - HexDigits, Digits - {'0', '1'}) #set[char]

type MainClass* = ref object of Control
  window:Window
  in_node:LineEdit
  out_node:Label
  dec_node, bin_node, hex_node, bin_check:BaseButton

method ready(self: MainClass) {.gdsync.} =
  if isRunningInEditor: return

  self.window = self.getWindow(); self.window.minSize = vector2i(325, 225); self.window.maxSize = vector2i(960, 480)

  self.in_node = self/"grid/inbox" as LineEdit; self.out_node = self/"grid/a/outlabel" as Label
  self.dec_node = self/"grid/decimal_button" as BaseButton
  self.bin_node = self/"grid/binary_button" as BaseButton; self.bin_check = self/"grid/binary_check" as BaseButton
  self.hex_node = self/"grid/hex_button" as BaseButton

  print "in signal: " & $(self.in_node.connect("text_changed", self.callable "inbox_text_changed"))
  print "dec signal: " & $(self.dec_node.connect("pressed", self.callable "submit_decimal"));
  print "bin signal: " & $(self.bin_node.connect("pressed", self.callable "submit_binary"))
  print "hex signal: " & $(self.hex_node.connect("pressed", self.callable "submit_hex"))

  self.out_node.text = "Hello from Nim-lang!"; print("Ready!")
  #print(benchmark()) #benchmark from convert.nim


proc disable_all_buttons(self: MainClass, message: string) =
  (self.dec_node.disabled, self.bin_node.disabled, self.hex_node.disabled) = (true, true, true)
  self.out_node.text = message

proc inbox_text_changed(self: MainClass, intext: string) {.gdsync.} =
  if nonhex_chars in intext or intext.len == 0: self.disable_all_buttons("Waiting for valid input."); return #self chain needed when nodes handled
  if intext.len > 63: self.disable_all_buttons("Input too large, causes overflow!"); return
  self.out_node.text = "Waiting for button choice."; self.hex_node.disabled = false
  if intext.len > 15:
    self.hex_node.disabled = true
    if hex_letters in intext:
      (self.dec_node.disabled, self.bin_node.disabled) = (true, true)
      self.out_node.text = "Input hexadecimal too large, causes overflow!"; return #toHex limitation
  if hex_letters in intext:
    (self.dec_node.disabled, self.bin_node.disabled) = (true, true)
    self.out_node.text = "Live hexadecimal conversion is:\n" & $(intext.parseHexInt) & " in decimal"; return
  if intext.len < 20 and parseInt(intext) == 0: self.disable_all_buttons("Waiting for valid input. 0."); return
  if intext.len >= 20: #this should've been handled in the old version, too
    self.dec_node.disabled = true
    if nonbinary_numbers in intext: self.out_node.text = "Input decimal too large, causes overflow!"; return
  if nonbinary_numbers in intext: self.bin_node.disabled = true; self.dec_node.disabled = false
  else:
    (self.dec_node.disabled, self.bin_node.disabled) = (false, false)
    if self.bin_check.is_pressed:
      if intext.len < 20: self.out_node.text = "Live binary conversion is:\n" & $(intext.parseBinInt) & " in decimal"
      else: self.out_node.text = "Input decimal too large to parse for live convert, please use button"

proc submit_decimal(self: MainClass) {.gdsync.} = self.out_node.text = convert_from_decimal($(self.in_node.text))
proc submit_binary(self: MainClass) {.gdSync.} = self.out_node.text = convert_from_binary($(self.in_node.text))
proc submit_hex(self: MainClass) {.gdSync.} = self.out_node.text = convert_from_hexadecimal($(self.in_node.text))
