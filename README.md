# segmented

A Typst library for rendering seven-segment displays directly in your documents.

The library provides two functions:

- `segdisplay`: Render a seven-segment display with individually controlled segments.
- `display-digit`: Render a numeric digit (0–9) using a seven-segment display.

Both functions support customizable dimensions, fill colors, and stroke styles.

The display maintains a fixed aspect ratio of approximately **478:697** (width:height).

## Installation

Import the library straight into your Typst document:

(To be published to Typst Universe).

In the meantime, `git clone` this repo and import locally:

```typst
#import "segmented/lib.typ": *
```

## Usage

### Basic Usage

#### Displaying a digit

Use `display-digit` to render a numeric digit:

```typst
#display-digit(digit: 0)
#display-digit(digit: 1)
#display-digit(digit: 2)
#display-digit(digit: 3)
#display-digit(digit: 4)
#display-digit(digit: 5)
#display-digit(digit: 6)
#display-digit(digit: 7)
#display-digit(digit: 8)
#display-digit(digit: 9)
```

The `digit` parameter accepts integers from `0` to `9`.

#### Displaying something else

If you need to display something other than a digit, you can also use `segdisplay` to render some other pattern of segments:

```typst
#segdisplay(
  width: 24pt,
  segments: (false, true, true, true, true, true, true, false),
)
```

## Documentation

### `display-digit`

Renders a numeric digit using a seven-segment display.

```typst
#display-digit(
  width: 16pt,
  fill-on: red,
  stroke-on: (paint: black, thickness: 0.4pt, join: "bevel"),
  fill-off: rgb("#5f5f5f"),
  stroke-off: (paint: black, thickness: 0.4pt, join: "bevel"),
  digit: 0,
  dot: false,
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `width` | Length | `16pt` | Width of the display. |
| `fill-on` | Paint | `red` | Fill of active segments. |
| `stroke-on` | Stroke | Black, 0.4pt | Stroke of active segments. |
| `fill-off` | Paint | `rgb("#5f5f5f")` | Fill of inactive segments. |
| `stroke-off` | Stroke | Black, 0.4pt | Stroke of inactive segments. |
| `digit` | Integer | `0` | Digit to display, from 0 to 9. |
| `dot` | Boolean or Integer | `false` | Whether the decimal point is active. |

**Returns:** Typst content.

**Assertions:**

- `digit` must be an integer between `0` and `9`.
- `dot` must be a Boolean or an integer between `0` and `1`.

### `segdisplay`

Renders a seven-segment display with individually configurable segments.

```typst
#segdisplay(
  width: 16pt,
  fill-on: red,
  stroke-on: auto,
  fill-off: rgb("#5f5f5f"),
  stroke-off: auto,
  segments: (false, false, false, false, false, false, false, false),
)
```

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `width` | Length | `16pt` | Width of the display. |
| `fill-on` | Paint | `red` | Fill of active segments. |
| `stroke-on` | Stroke | `auto` | Stroke of active segments. |
| `fill-off` | Paint | `rgb("#5f5f5f")` | Fill of inactive segments. |
| `stroke-off` | Stroke | `auto` | Stroke of inactive segments. |
| `segments` | Array | Eight `false` values | State of each segment. |

**Returns:** Typst content.

**Assertions:**

- `segments` must be an array containing exactly eight elements.
- Elements must consistently be either Booleans or integers (`0` or `1`).
- Boolean and integer values cannot be mixed in the same array.

## Segment Mapping

The following diagram illustrates the segment positions:

```text
     ──── 0 ────
    |           |
    5           1
    |           |
    |──── 6 ────|
    |           |
    4           2
    |           |
    |──── 3 ────|  (7)
```

## Roadmap

The following features are planned:

- Some way to create presets for the displays.
- Different styles of segmented displays.
