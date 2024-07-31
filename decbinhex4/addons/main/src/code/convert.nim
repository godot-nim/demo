import std / [math, strutils, #[benchmark only]# std/times]

# the asterisk is so it can be called from another file when imported
proc convert_from_decimal*(input_decimal: string):string =
  var result_binary:string
  if input_decimal.len < 20:
    result_binary =
      strip((input_decimal.parseInt).toBin(63), trailing = false, chars = {'0'})
  else: result_binary = "Output binary too large!"
  let result_hex:string =
    strip(input_decimal.parseInt.toHex, trailing = false, chars = {'0'})
  return("Binary is: " & result_binary & "\nHexadecimal is: " & result_hex)

proc convert_from_binary*(input_binary: string):string =
  var sum_decimal: int
  for i, c in input_binary:
    #use length to invert i... to get place without a decreasing variable
    if c == '1': sum_decimal += 2^abs(i - (input_binary.len - 1))
  let result_hex:string =
    strip(sum_decimal.toHex, trailing = false, chars = {'0'})
  return("Decimal is: " & ($sum_decimal).insertSep(',') &
    "\nHexadecimal is: " & result_hex)

proc convert_from_hexadecimal*(input_hex:string):string =
  var sum_decimal:int
  var hex_pos:int = input_hex.len - 1
  for c in input_hex:
    case c #the number at the end is an offset to the ASCII code
    of '0'..'9': sum_decimal += (16^hex_pos) * (int(c) - 48)
    of 'a'..'f': sum_decimal += (16^hex_pos) * (int(c) - 87)
    of 'A'..'F': sum_decimal += (16^hex_pos) * (int(c) - 55)
    else: break
    hex_pos -= 1
  let result_binary:string =
    strip(sum_decimal.toBin(63), leading = true, trailing = false, chars = {'0'})
  return("Decimal is: " & ($sum_decimal).insertSep(',') &
    "\nBinary is: " & result_binary)

proc benchmark*():string =
  let t1:float = cpuTime()
  var bench_sum:int64
  for n in 0..<100000000: bench_sum += n #lessthan to match GDscript behavior
  let t2:float = cpuTime()
  return($("Sum is " & $bench_sum & "\n" &
    "Time taken: " & $(t2-t1) & "s? cpu time"))
