#import "../lib.typ": *

#set text(font: "Cascadia Code", size: 35pt)

#set page(width: auto, height: auto, margin: (left: 5mm, right: 3cm, top: 5mm, bottom: 5mm))

#seg-display-digit(digit: 8, width: 100mm, stroke-on: (thickness: 2pt, join: "bevel"), dot: true, stroke-box: none)

#place(
  left + top, 
  dx: 50mm,
  dy: 2.5mm
)[0]

#place(
  left + top, 
  dx: 88mm,
  dy: 42mm
)[1]

#place(
  left + top, 
  dx: 80mm,
  dy: 96mm
)[2]

#place(
  left + top, 
  dx: 90mm,
  dy: 135mm
)[7]

#place(
  left + top, 
  dx: 90mm,
  dy: 135mm
)[7/dot]

#place(
  left + top, 
  dx: 36mm,
  dy: 135mm
)[3]

#place(
  left + top, 
  dx: -1mm,
  dy: 96mm
)[4]

#place(
  left + top, 
  dx: 5mm,
  dy: 42mm
)[5]

#place(
  left + top, 
  dx: 44mm,
  dy: 57mm
)[6]