import std / [os, json, strutils]

import pkg/pixie
import image2html/lib

{.warning: "If you are importing this library, use import pkg/image2html/lib rather than pkg/image2html"}

proc main =
  if paramCount() < 1:
    quit("Wrong arguments. Example: " & getAppFilename().splitPath().tail & " file.jpg output.html")
  elif not fileExists(paramStr(1)):
    quit(escapeJson("File " & paramStr(1)) & " does not exist.")

  const base = staticRead(currentSourcePath().parentDir  / "base.html")
  # {title} {table}

  # let image = readImage(currentSourcePath().parentDir / "../assets/bird512.png")
  let
    image = readImage(paramStr(1))
    converted = if paramCount() > 1: paramStr(2)
      else: paramStr(1) & ".html"

  echo "Length: ", len(image.data)
  echo "Generating the file..."
  writeFile(
    converted,
    base.multiReplace(
      ("{title}", "image"),
      ("{table}", image.convertToHtml(size="2em"))
    )
  )
  echo "Done! Converted into " & escapeJson(converted)

  # echo $Tag(name: "div", children: @[
  #   Tag(name: "img", properties: @[("src", "localhost/asd")], children: @[
  #     Tag(name: "div", children: @[
  #       Tag(name: "img", properties: @[("src", "localhost/asd")])
  #     ])
  #   ])
  # ])

when isMainModule:
  main()
