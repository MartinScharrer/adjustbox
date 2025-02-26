LaTeX bundle `adjustbox`
========================
Copyright (c) 2011-2025 by Martin Scharrer <martin.scharrer@web.de>  
License: LaTeX Project Public License, v1.3 or later: http://www.latex-project.org/lppl.txt  
Repository: https://github.com/MartinScharrer/adjustbox  
Issues: https://github.com/MartinScharrer/adjustbox/issues  

This bundle contains the the `adjustbox` package and its auxiliary packages `trimclip` and `adjcalc`.
The initial purpose of `adjustbox` was to supplement the standard `graphics/x` package, 
which defines the macros `\resizebox`, `\scalebox` and `\rotatebox`, with the macros `\trimbox` and `\clipbox`.
An additional `\marginbox` macro is also provided.
These macros are now placed in the dedicated package `trimclip` which is loaded by `adjustbox`.
The package comes with clipping driver files are provided for `pdftex` (incl. LuaLaTeX), `dvips` and `xetex`. A
fall-back driver which uses the `pgf` package is still included. 
The driver files got written by Joseph Wright (LaTeX3 project) and the package author.

The main feature of `adjustbox` is the general `\adjustbox` macro which extends the `key=value`
interface of `\includegraphics` from the `graphicx` package, and applies it to general text
content. It also provides further text/box modifications keys, macros and envionments.

Both `adjustbox` and `trimclip` use the `adjcalc` package to allow for algebraic expressions for all length
arguments. The `adjcalc` package can use either e-TeX, the `calc` package or the `pgfmath` package.

All macros use the authors other package `collectbox` to read the content as box and not as
macro argument. This allows for all forms of content including special material like verbatim content.
A special feature of `collectbox` is used to provide matching environments with the identical names as the
macros.

[![CTAN](https://img.shields.io/ctan/l/adjustbox)](http://www.latex-project.org/lppl/)
[![CTAN](https://img.shields.io/ctan/v/adjustbox)](http://www.ctan.org/pkg/adjustbox)
[![GitHub issues](https://img.shields.io/github/issues/MartinScharrer/adjustbox)](https://github.com/MartinScharrer/adjustbox/issues )
