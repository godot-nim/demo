import std/strutils, pure_convert #[pure_convert.nim, last pure-nim import]#, gdext
import gdextgen/classes / [gdInput, gdLineEdit, gdLabel, gdBaseButton, gdWindow]

const
  hex_letters:set[char] = HexDigits - Digits
  nonhex_chars:set[char] = AllChars - HexDigits
  nonbinary_nums:set[char] = Digits - {'0', '1'}
  msg_input:string = "Waiting for valid input."

type MainClass* = ref object of Control
  window:Window
  in_node:LineEdit
  out_node:Label
  dec_node, bin_node, hex_node, bin_check:BaseButton


method ready(self:MainClass) {.gdsync.} =
  if isRunningInEditor: return

  self.window = self.getWindow();
  self.window.minSize = vector2i(325, 225)
  self.window.maxSize = vector2i(960, 480)

  self.in_node = self/"grid/inbox" as LineEdit
  self.out_node = self/"grid/a/outlabel" as Label
  self.dec_node = self/"grid/decimal_button" as BaseButton
  self.bin_node = self/"grid/binary_button" as BaseButton
  self.hex_node = self/"grid/hex_button" as BaseButton
  self.bin_check = self/"grid/binary_check" as BaseButton

  print "in signal: " &
    $(self.in_node.connect("text_changed", self.callable "inbox_text_changed"))
  print "dec signal: " &
    $(self.dec_node.connect("pressed", self.callable "submit_decimal"));
  print "bin signal: " &
    $(self.bin_node.connect("pressed", self.callable "submit_binary"))
  print "hex signal: " &
    $(self.hex_node.connect("pressed", self.callable "submit_hex"))

  self.out_node.text = "Hello from Nim-lang!"; print("Ready!")
  #print(benchmark()) #[benchmark from convert.nim]#


proc disable_all_buttons(self:MainClass, message:string) =
  (self.dec_node.disabled, self.bin_node.disabled, self.hex_node.disabled) =
    (true, true, true)
  self.out_node.text = message

proc inbox_text_changed(self:MainClass, intext:string) {.gdsync.} =
  case intext.len
  of 0: self.disable_all_buttons(msg_input); return #self chain needed when dealing w/nodes
  of 1..15:
    (self.dec_node.disabled, self.bin_node.disabled, self.hex_node.disabled) =
      (false, false, false)
  of 16..19:
    self.hex_node.disabled = true
    (self.dec_node.disabled, self.bin_node.disabled) = (false, false)
  of 20..63:
    (self.hex_node.disabled, self.dec_node.disabled) = (true, true)
    if nonbinary_nums notin intext: self.bin_node.disabled = false
  of 64..high(int): self.disable_all_buttons("Input overflow!"); return
  else: print "what"

  if nonhex_chars in intext: self.disable_all_buttons(msg_input); return
  if hex_letters in intext and self.hex_node.disabled:
    (self.dec_node.disabled, self.bin_node.disabled) = (true, true)
    self.out_node.text = "Input hexadecimal overflow!"; return
  elif hex_letters in intext:
    self.out_node.text = "Live hexadecimal conversion:\n" & ($(intext.parseHexInt)).insertSep(',') & " in decimal"
    (self.dec_node.disabled, self.bin_node.disabled) = (true, true); return
  if intext.len < 20: #parseInt cannot handle it
    if intext.parseInt == 0: self.disable_all_buttons(msg_input & " 0."); return
  else: #this can be collapsed, it's extra functionality
    try: #below: an empty string is not 0
      if 0 == (("0" & strip(intext, trailing = false, chars = {'0'})).parseInt):
        self.disable_all_buttons(msg_input & " 00."); return
    except ValueError: discard #I tried
  if nonbinary_nums in intext and self.dec_node.disabled:
    self.out_node.text = "Input decimal overflow!"; return
  if nonbinary_nums in intext: self.bin_node.disabled = true
  if self.bin_check.is_pressed:
    self.out_node.text = "Live binary conversion:\n" &
      ($(intext.parseBinInt)).insertSep(',') & " in decimal"; return
  self.out_node.text = "Waiting for choice."

proc submit_decimal(self:MainClass) {.gdsync.} =
  self.out_node.text = convert_from_decimal($(self.in_node.text)) #[from pure_convert.nim]#
proc submit_binary(self:MainClass) {.gdSync.} =
  self.out_node.text = convert_from_binary($(self.in_node.text))
proc submit_hex(self:MainClass) {.gdSync.} =
  self.out_node.text = convert_from_hexadecimal($(self.in_node.text))
