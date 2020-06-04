---
layout: post
title: Installing Apple San Francisco Fonts on Linux
date: 2020-06-04
---

Apple has always had a knack for producing and using high-quality typography.
Not too long ago, they switched the font for their UI from the classic
Helvetica Neue (a typeface originating from Switzerland, known for precision
watches) over to their own custom typeface, which they called San Francisco.

![Apple SF Pro Font](/assets/images/sf-pro-font.png)

I like this font family so much that I've started using the monospaced variant
for my default Terminal font. It replaced the Menlo I was using before, which
is also very legible and has served me very well.

![Alacritty with SF Mono Font](/assets/images/alacritty-sf-mono.png)


I try to use the same software and configuration on different platforms. My
terminal emulator, Alacritty, is written in Rust and cross-platform. The tools
I use daily, which is mostly `tmux` and `vim` for development, similarly work
on all platforms. However, Linux does not have the San Francisco typeface
available, out of the box, for licensing reasons.

Apple offers downloads of its San Francisco fonts for free from its [developer
page](https://developer.apple.com/fonts). 

![Apple Developer Fonts Download Page](/assets/images/apple-developer-fonts.png)

I wanted to get those fonts installed on my Linux machines as well, so that
I can use exactly the same Alacritty configuration on all platforms. However,
they only offer the fonts as a `.dmg` download, which is a disk image file and
is how software is typically distributed on macOS (it's mounted rather than
uncompressed, so it behaves more like an inserted CD drive, and has the advantage
that you can run Applications from mounted, compressed disk images without
having to unpack them first). The question is, can I get Linux to extract
this somehow? After all, Apple's macOS is heavily UNIX-based.

    $ wget -q https://developer.apple.com/design/downloads/SF-Font-Pro.dmg
    $ file SF-Font-Pro.dmg
    SF-Font-Pro.dmg: zlib compressed data

Interesting, so a `.dmg` file is just some zlib-compressed blob, similar to
how a `.tar.gz` file is a gzip-compressed tar blob. The `7z` command from the
`p7zip` package can extract a surprising amount of archives, and it can easily
extract disk image files, too.

    $ 7z -oSF-Font-Pro x SF-Font-Pro.dmg
    $ cd SF-Font-Pro
    $ ls
    SanFranciscoPro
    $ ls SanFranciscoPro
    '[HFS+ Private Data]'  'San Francisco Pro.pkg'

Okay, so this disk image file contains a `.pkg` file. The HFS+ Private Data
folder can be ignored, as it is empty. What's in the `.pkg` file? Let's find out.

    $ cd SanFranciscoPro
    $ file 'San Francisco Pro.pkg'
    San Francisco Pro.pkg: xar archive version 1, SHA-1 checksum

A XAR archive, Apple likes to use those. It's similar to a TAR archive, but it
uses XML for the table of contents. We don't have anything on Ubuntu to unpack
this natively, so we'll have to build something. Thankfully, there's some code
up on Google Code that we can compile and use to unpack this.

    $ cd ~/Downloads
    $ wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/xar/xar-1.5.2.tar.gz
    $ tar xf xar-1.5.2.tar.gz
    $ cd xar-1.5.2
    $ ./configure
    checking for gcc... gcc
    ...
    $ make -j 4
    ...
    $ ./src/xar --version
    xar 1.5.2
    
After running this, we have a working build of XAR 1.5.2 in the `src/` folder.
We can now use this to unpack the San Francisco Pro font package.

    $ mkdir unpacked && cd unpacked
    $ ../../../xar-1.5.2/src/xar -x -f '../San Francisco Pro.pkg'
    $ ls -l
    -rwxr-xr-x 1 patrick patrick 546 Oct 28  2019 Distribution
    drwxr-xr-x 1 patrick patrick  26 Jun  4 11:34 Resources
    drwxr-xr-x 1 patrick patrick  42 Jun  4 11:34 SanFranciscoPro.pkg
    $ ls -lh SanFranciscoPro.pkg
    -rwxr-xr-x 1 patrick patrick 2.2K Oct 28  2019 Bom
    -rwxr-xr-x 1 patrick patrick  287 Oct 28  2019 PackageInfo
    -rwxr-xr-x 1 patrick patrick  28M Oct 28  2019 Payload

We have a few uninteresting files, but the `Payload` file inside the
SanFranciscoPro.pkg folder is what we're interested in, because that seems
to contain some data. Let's take a closer peek at it.

    $ cd SanFranciscoPro.pkg
    $ file Payload
    Payload: gzip compressed data, from Unix

It's gzip compressed data, that's something we can handle. But what's inside?
We can find out, too.

    $ gunzip < Payload | file -
    /dev/stdin: ASCII cpio archive (pre-ARV4 or odc)

A CPIO archive. I've heard of this only from reading the POSIX standard, CPIO
is similar to `tar`, if I understand it correctly. So we can use `cpio` to extract
that.

    $ gunzip < Payload | cpio -i
    85030 blocks
    $ ls
    Bom  Library  PackageInfo  Payload

Extracting this has produced a `Library` folder. That sounds suspiciously like
a macOS filesystem folder.

    $ ls Library
    Fonts
    $ ls Library/Fonts
    SF-Pro-Display-BlackItalic.otf
    ...

Jackpot! 

All that's left to do is to install them on the local system. This is done
easily by copying them to the `~/.fonts` folder and updating the font cache.

    $ mkdir -p ~/.fonts/SF-Pro
    $ cp Library/Fonts/*.otf ~/.fonts/SF-Pro/
    $ fc-cache -vf

This should result in the fonts being available and ready to use. 

