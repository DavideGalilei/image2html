<p align="center">
    <a href="https://github.com/DavideGalilei/image2html">
        <img src="/assets/banner.jpg" alt="image to html banner image" />
    </a>
    <br>
    <b>Use black magic to convert an image to html</b>
</p>


# image2html
This is a tool to convert any image to html tables (beware using it for large images). Made with [Nim](https://nim-lang.org/) 👑


# Example
![example image](/assets/example.jpg)


# Installation
```bash
$ nimble install https://github.com/DavideGalilei/image2html
```


# Installation (library-usage only)
```bash
$ nimble install -d:noBinary https://github.com/DavideGalilei/image2html
```


# Usage
```bash
$ image2html file.jpg output.html
```
---
_Or as a library..._
```nim
import pkg/image2html, pixie

let html = convertToHtml(readImage("path/to/example.png"))
writeFile("path/to/output.html", html)
```


# FAQ
> How does this work?

This project uses pixie library to extract pixels from images. Then it converts them to `<th>` html tags with a `background-color` style property

> Why did you make this?

I was bored

> Is this useless then?

Yes, it is


# License
Licensed under the MIT License.
Click [here](/LICENSE) for further information.
