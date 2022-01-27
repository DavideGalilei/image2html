# Package
version = "0.1.0"
author = "Davide Galilei"
description = "Use black magic to convert an image to a html table"
license = "MIT"
srcDir = "src"
installExt = @["nim"]


when not defined(noBinary):
    # For docker builds or library-only usage
    bin = @["image2html"]


# Dependencies
requires "nim >= 1.4.2"
requires "pixie"
