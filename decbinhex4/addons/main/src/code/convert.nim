import math, strutils
import std/times #benchmark only

# the asterisk is so it can be called from another file when imported
proc convert_from_decimal*(input_decimal: string):string =
  var result_binary, result_hex:string
  if input_decimal.len < 20: result_binary = strip((input_decimal.parseInt).toBin(63), trailing = false, chars = {'0'})
  else: result_binary = "Output binary too large!"
  result_hex = strip(input_decimal.parseInt.toHex, trailing = false, chars = {'0'})
  return("Binary is: " & result_binary & "\nHexadecimal is: " & result_hex)

proc convert_from_binary*(input_binary: string):string =
  var result_decimal: int; var result_hex:string
  for i, c in input_binary:
    #use length to invert i... to get place without a decreasing variable
    if c == '1': result_decimal += 2^abs(i-(input_binary.len-1))
  result_hex = strip(result_decimal.toHex, trailing = false, chars = {'0'})
  return("Decimal is: " & $result_decimal & "\nHexadecimal is: " & result_hex)

proc convert_from_hexadecimal*(input_hex:string):string =
  var result_binary:string; var result_decimal:int
  var lengthvar_hex:int = input_hex.len-1
  for c in input_hex:
    case c #the number at the end is an offset to the ASCII code
    of '0'..'9': result_decimal += (16^lengthvar_hex) * (int(c)-48)
    of 'a'..'f': result_decimal += (16^lengthvar_hex) * (int(c)-87)
    of 'A'..'F': result_decimal += (16^lengthvar_hex) * (int(c)-55)
    else: break
    lengthvar_hex -= 1
  result_binary = strip(result_decimal.toBin(63), leading = true, trailing = false, chars = {'0'})
  return("Decimal is: " & $result_decimal & "\nBinary is: " & result_binary)

proc benchmark*():string =
  var t1: float = cpuTime()
  var bench_sum:int64
  for n in 0..<100000000: bench_sum+=n #the lessthan sign is to match GDscript output sum
  var t2: float = cpuTime()
  return($("Sum is " & $bench_sum & "\n" & "Time taken: " & $(t2-t1) & "s? cpu time"))
