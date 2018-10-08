---
layout: post
title: Playing with PostScript
date: 2018-10-08
summary: Ehhh
---

I recently re-watched an old [talk][MatasanoTalk] that the guys behind the [cryptopals crypto challenge][Cryptopals], also known as Matasano crypto challenge, did at BlackHat 2014. Both the talk and the crypto challenge are worth watching and playing around with, if you're into that kind stuff.

But there was something completely unrelated that caught my attention. They divided the challenge into multiple sets. They would give out set 1 to anyone, but to get the next ones, people needed to send in their code. That means that they were able to collect really good statistics on which programming languages people used to solve the sets.

Most people ended up doing it in Python. There were also some people using Golang, Ruby, C/C++, Java, Haskell. As you would expect. But one guy did the challenges in *PostScript*. What?

## What is PostScript

If you haven't heard of PostScript before, or you don't know much about it, then you're like me. The only reason I know PostScript at all is because some (old) computer science papers and books are only available in it. When you compile a LaTeX document, sometimes you'll get a <abbr>DVI</abbr> file which you need to convert to PostScript and then to <abbr>PDF</abbr>. Also, when you want to include an <abbr>SVG</abbr> into a LaTeX document, you'll (at least that's how I do it) convert it to <abbr>EPS</abbr> using Inkscape, because LaTeX doesn't support <abbr>SVG</abbr>s directly but happily takes anything PostScript.

I used to think of it as a kind of vector language from 1990, but apparently it's a bit more than that. It was invented by Adobe for use with printers. Basically, when you print a document, your computer converts whatever you're trying to print to a PostScript document, and sends that over to the printer. The document contains code that tells the printer how to print the file.

After a bit of research, I found a few slides about Embedded PostScript programming[^EPSProgramming], which taught me that PostScript is in fact a somewhat usable programming language. It is stack-based, has functions and loops. And you can get a <abbr>REPL</abbr> using `ghostscript`, which is awesome to try things out!

![GhostScript REPL](/assets/images/ghostscript-repl.png)

Next, I wanted to get a bit more of an overview than a few slides can provide. So I found a very nice overview[^Portfolio] about PostScript.


[^EPSProgramming]: <http://www.tcm.phy.cam.ac.uk/~mjr/eps.pdf>
[^Portfolio]: PostScript Postfolio <http://www.cburch.com/csbsju/cs/portfolio/postscript.pdf>
[MathematicalIllustrations]: http://www.math.ubc.ca/~cass/graphics/text/www/index.html
[ThinkingInPostScript]: http://cholla.mmto.org/computers/postscript/tips.pdf
[LearnPostScript]: https://staff.science.uva.nl/a.j.p.heck/Courses/Mastercourse2005/tutorial.pdf
[BlueBook]: https://www-cdf.fnal.gov/offline/PostScript/BLUEBOOK.PDF
[PostScriptTutorial]: http://paulbourke.net/dataformats/postscript/
[PostScriptReference]: https://www.adobe.com/content/dam/acom/en/devnet/actionscript/articles/PLRM.pdf
[MatasanoTalk]: https://youtu.be/iZa_XKpj9X4?t=539
[Cryptopals]: https://cryptopals.com
