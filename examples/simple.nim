import os, pixie, pkg/image2html/lib

let html = convertToHtml(readImage(currentSourcePath().parentDir / "../assets/bird16.png"))
writeFile(currentSourcePath().parentDir / "generated.html", html)
