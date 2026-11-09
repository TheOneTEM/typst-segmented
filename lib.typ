/// Internal function. Takes two points with a height difference, outputs a horizontal offset such that the angle between the spanning line and the vertical axis is 10 degrees. 
#let __internal-ten-degree-angle__(pos1, pos2) = (pos2 - pos1) * 0.17632698070846506

/// Renders a 7-segment display on your document. 
///
/// - width (): The width of the display. Aspect ratio is fixed at 478:697; this ratio is taken from a technical diagram for an actual segmented display.
/// - stroke-box (color | stroke): The stroke of the surrounding box.
/// - fill-box (none | color | gradient | tiling): The fill of the surrounding box.
/// - fill-on (): The fill of the polygons when they are turned on.
/// - stroke-on (stroke): The stroke of the polygons when they are turned on.
/// - fill-off (): The fill of the polygons when they are turned off.
/// - stroke-off (stroke): The stroke of the polygons when they are turned off.
/// - segments (array): Boolean or integer (0..1) array that dictates which lights are turned on. One-hot, zero-indexed. 
/// -> content
#let seg-display(
  width: 16pt, 
  fill-box: none,
  stroke-box: black,
  fill-on: red, 
  fill-off: rgb("#eeeeee"), 
  stroke-on: (paint: black, thickness: 0.5pt, join: "bevel"), 
  stroke-off: (paint: black, thickness: 0.3pt, join: "bevel"),
  segments: (false, false, false, false, false, false, false, false)
) = {
  // Assert type of light
  assert.eq(type(segments), array, message: "Error: `segments` must be an array!")
  assert.eq(segments.len(), 8, message: "Error: Array `segments` must have 8 members!")

  let bool_array = if type(segments.at(0)) == bool {
    true
  } else {
    false
  }

  for light in segments {
    if bool_array {
      assert(type(light) == bool, message: "Error: Inconsistent types in array `segments`: expected bool")
    } else {
      assert(type(light) == int and 0 <= light and light <= 1, message: "Error: Inconsistent types in array `segments`: expected int: 0 or 1")
    }
  }

  let new-segments = if bool_array {
    segments
  } else {
    segments.map((l) => {
      if l == 0 {
        false
      } else if l == 1 {
        true
      }
    })
  }
  
  let fills = new-segments.map(
    (l) => {
      if l {
        fill-on
      } else {
        fill-off
      }
    }
  )

  let strokes = new-segments.map(
    (l) => {
      if l {
        stroke-on
      } else {
        stroke-off
      }
    }
  )
  
  box(
    height: width * 1.45815899582,
    width: width,
    fill: fill-box,
    stroke: stroke-box
  )[
    #let base-h-spacing-left = 8.332455539497054%
    #let base-h-spacing-right = base-h-spacing-left + 67.782426778%

    #let base-v-spacing-top = 9.25394548%
    #let base-v-spacing-bottom = 100% - base-v-spacing-top

    #let middle-point-height = base-v-spacing-top + 40.746054519%

    #let segment-width = 11.50627615%
    #let segment-height = 7.890961262%

    #let ten-degrees-h-offset(height) = __internal-ten-degree-angle__(base-v-spacing-bottom, height)

    #place(
      top + left,
      polygon(
        fill: fills.at(0),
        stroke: strokes.at(0),
        (base-h-spacing-left - ten-degrees-h-offset(base-v-spacing-top), base-v-spacing-top),
        (base-h-spacing-right - ten-degrees-h-offset(base-v-spacing-top), base-v-spacing-top),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(base-v-spacing-top + segment-height), base-v-spacing-top + segment-height),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(base-v-spacing-top + segment-height), base-v-spacing-top + segment-height),
      )
    )

    #place(
      top + left,
      polygon(
        fill: fills.at(1),
        stroke: strokes.at(1),
        (base-h-spacing-right - (segment-width /2) - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(middle-point-height - (segment-height /2)), middle-point-height - (segment-height /2)),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(base-v-spacing-top + segment-height), base-v-spacing-top + segment-height),
        (base-h-spacing-right - ten-degrees-h-offset(base-v-spacing-top), base-v-spacing-top),
        (base-h-spacing-right - ten-degrees-h-offset(middle-point-height), middle-point-height),
      )
    )
    #place(
      top + left,
      polygon(
        fill: fills.at(2),
        stroke: strokes.at(2),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(base-v-spacing-bottom - segment-height), base-v-spacing-bottom - segment-height),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(middle-point-height + (segment-height / 2)), middle-point-height + (segment-height / 2)),
        (base-h-spacing-right - (segment-width / 2) - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-right - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-right, base-v-spacing-bottom)
      )
    )
    #place(
      top + left,
      polygon(
        fill: fills.at(3),
        stroke: strokes.at(3),
        (base-h-spacing-left + segment-width + ten-degrees-h-offset(base-v-spacing-bottom - segment-height), base-v-spacing-bottom - segment-height),

        (base-h-spacing-right - segment-width - ten-degrees-h-offset(base-v-spacing-bottom - segment-height), base-v-spacing-bottom - segment-height),

        (base-h-spacing-right, base-v-spacing-bottom),

        (base-h-spacing-left, base-v-spacing-bottom),
      )
    )
    #place(
      top + left,
      polygon(
        fill: fills.at(4),
        stroke: strokes.at(4),
        (base-h-spacing-left, base-v-spacing-bottom),
        (base-h-spacing-left - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-left + (segment-width / 2) - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(middle-point-height + (segment-height / 2)), middle-point-height + (segment-height / 2)),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(base-v-spacing-bottom - segment-height), base-v-spacing-bottom - segment-height),
      )
    )
    #place(
      top + left,
      polygon(
        fill: fills.at(5),
        stroke: strokes.at(5),
        (base-h-spacing-left + (segment-width / 2) - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-left - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-left - ten-degrees-h-offset(base-v-spacing-top), base-v-spacing-top),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(base-v-spacing-top + segment-height), base-v-spacing-top + segment-height),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(middle-point-height - (segment-height / 2)), middle-point-height - (segment-height / 2)),
      )
    )
    #place(
      left + top,
      polygon(
        fill: fills.at(6),
        stroke: strokes.at(6),
        (base-h-spacing-left + (segment-width / 2) - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(middle-point-height - segment-height / 2), middle-point-height - segment-height / 2),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(middle-point-height - segment-height / 2), middle-point-height - segment-height / 2),
        (base-h-spacing-right - segment-width / 2 - ten-degrees-h-offset(middle-point-height), middle-point-height),
        (base-h-spacing-right - segment-width - ten-degrees-h-offset(middle-point-height + segment-height / 2), middle-point-height + segment-height / 2),
        (base-h-spacing-left + segment-width - ten-degrees-h-offset(middle-point-height + segment-height / 2), middle-point-height + segment-height / 2)
      )
    )
    #place(
      left + top,
      dx: base-h-spacing-right + segment-width / 2,
      dy: base-v-spacing-bottom - segment-height + 1%,
      ellipse(
        fill: fills.at(7),
        stroke: strokes.at(7),
        height: segment-height,
        width: segment-width
      )
    )
  ]
}


/// A wrapper function to display a digit on a seven-segment display.
///
/// - width (): The width of the display. Aspect ratio is fixed, about 478:697.
/// - stroke-box (): The stroke of the surrounding box.
/// - fill-box (): The fill of the surrounding box.
/// - fill-on (): The fill of the polygons when they are turned on.
/// - stroke-on (): The stroke of the polygons when they are turned on.
/// - fill-off (): The fill of the polygons when they are turned off.
/// - stroke-off (): The stroke of the polygons when they are turned off.
/// - digit (): The digit to display.
/// - dot (): Whether or not to turn the dot on.
/// -> content
#let seg-display-digit(
  width: 16pt, 
  fill-box: none,
  stroke-box: black,
  fill-on: red, 
  fill-off: rgb("#eee"), 
  stroke-on: (paint: black, thickness: 0.5pt, join: "bevel"), 
  stroke-off: (paint: black, thickness: 0.3pt, join: "bevel"),
  digit: 0,
  dot: false
) = {
  assert(type(digit) == int and 0 <= digit and digit <= 9, message: "Error: Invalid digit!")
  assert(type(dot) == bool or (type(dot) == int and 0 <= dot and dot <= 1), message: "Error: `mismatched types in argument `dot` (expected bool or int(0..1))!")

  let new_dot = if type(dot) == int {
    dot
  } else {
    if dot {
      1
    } else {
      0
    }
  }

  let to-display = if digit == 0 {
    (1,1,1,1,1,1,0,new_dot)
  } else if digit == 1 {
    (0,1,1,0,0,0,0,new_dot)
  } else if digit == 2 {
    (1,1,0,1,1,0,1,new_dot)
  } else if digit == 3 {
    (1,1,1,1,0,0,1,new_dot)
  } else if digit == 4 {
    (0,1,1,0,0,1,1,new_dot)
  } else if digit == 5 {
    (1,0,1,1,0,1,1,new_dot)
  } else if digit == 6 {
    (1,0,1,1,1,1,1,new_dot)
  } else if digit == 7 {
    (1,1,1,0,0,0,0,new_dot)
  } else if digit == 8 {
    (1,1,1,1,1,1,1,new_dot)
  } else if digit == 9 {
    (1,1,1,1,0,1,1,new_dot)
  }

  seg-display(width: width, fill-box: fill-box, stroke-box: stroke-box, fill-on: fill-on, stroke-on: stroke-on, fill-off: fill-off, stroke-off: stroke-off, segments: to-display)
}