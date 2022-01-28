import std / [strutils, strformat, sequtils, json]
import pixie


type
  Tag* = object
    name*: string
    properties*: seq[(string, string)]
    children*: seq[Tag]


proc toString*(tag: Tag, depth: int = 1, tabSize: int = 4): string =
  let
    open = &"<{tag.name}" &
      (if len(tag.properties) == 0: ""
      else: ' ' & tag.properties.mapIt(
        &"{it[0]}={escapeJson(it[1])}"
      ).join(" ")) & '>'

    close = if len(tag.children) == 0: &"</{tag.name}>"
      else: ' '.repeat((depth - 1) * tabSize) & &"</{tag.name}>"

    indentation = ' '.repeat(depth * tabSize)

  if len(tag.children) == 0:
    return open & close
  return open & '\n' &
    tag.children.mapIt(
       indentation & toString(it, depth + 1, tabSize = tabSize)
    ).join("\n") & '\n' &
    close


const tabSize* {.intdefine.} = 4
proc `$`*(tag: Tag): string = toString(tag, tabSize = tabSize)


proc htmlColor*(pixel: ColorRGBX, transparency: uint8 = 0): string =
  let a = (if transparency == 0: float(pixel.a)
           else: float(transparency)) / 255

  return &"rgba({pixel.r}, {pixel.g}, {pixel.b}, {a})"


proc convertToHtml*(image: Image, size: string = "20em", tabSize: int = tabSize): string =
  # echo htmlColor(image.data[0])
  var generated: Tag = Tag(name: "table", properties: @{
    "cellspacing": size,
    "cellpadding": size,
    "style": "border-collapse: collapse;",
  })
  var
    row: int
    column: int

  while row < image.height:
    var tableRow = Tag(name: "tr")

    column = 0
    while column < image.width:
      let
        pos = row * image.height + column
        color = htmlColor(
          image.data[pos],
          transparency = 255,
        )

      var skip = 1
      while (column + skip) < image.width and image.data[pos] == image.data[pos + skip]:
        inc skip
      # echo "current_ ", row, " - ", column, " - ", row * image.height + column + skip
      var props = @{
        "style": &"background-color: {color};",
      }

      if skip > 1:
        props.add(("colspan", $skip))

      tableRow.children.add(Tag(
        name: "td",
        properties: props,
      ))
      inc column, skip
    generated.children.add(tableRow)
    inc row

  return toString(generated, tabSize = tabSize)
