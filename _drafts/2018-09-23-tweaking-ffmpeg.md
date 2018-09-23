---
layout: post
date: 2018-09-23
title: Tweaking ffmpeg
---

Today I explored and played with ffmpeg. Kind of unintentionally, actually. I was playing around with QuickTime, recording some screencasts, just to see what it can do. It's actually pretty easy to do! You just open QuickTime, hit the 'New Screen Recording' menu button and off you go. But there was one problem.

Of course, these days laptops have very large screen resolutions. Even small 13" laptops like mine have a better resolution than full HD (which is 1680 by 1080 pixels) thanks to the increased pixel density. This means that when you make screen recordings, there is a *hell* of a lot of data the needs to be stored. 

The result is that even a 30-minute screen recording can easily get up to 4GB in size. With my slow internet connection, uploading such a recording to anywhere would take months. But thankfully, I don't have to: there a re awesome tools like *ffmpeg* that let me re-encodde my screencasts and other movies and videos. It is very flexible, I can tell it which resolution, framerate or quality I want, and it does it. It takes a long time: on my machine, re-encoding a 30-minute screencast, which is around 2500 by 1800 pixels and 4GB in size, takes about 40 minutes. But the resulting file is much smaller: it can be less than 100MB, if I choose a high compression ratio.

## Options

The trick is that *ffmpeg* takes a *lot* of options, and you have to tweak them just right to get the desired quality you want, without it being a huge file size. And that is exactly what I did. So, let me show you which options I have found to work, and what they do.

    ffmpeg -i input.mov -movflags +faststart -c:v libx264 -r 30 -vf scale=-1:1440 -crf 25 -preset slow -profile:v high -level 4.0 -c:a aac -b:a 192k -ar 48000 -pic_fmt yuv420p output.mp4

That is one hell of a long line. So, let's take it apart. The basic invocation of <abbr>ffmpeg</abbr> is very simple.

    ffmpeg -i input.mov output.mp4

With this invocation, <abbr>ffmpeg</abbr> will transcode the file *input.mov* into the file *output.mp4*. But with this invocation, we can't really control what it does except changing the container format from <abbr>mov</abbr> to <abbr>mp4</abbr>. So, we can specify some additional flags to control it's behaviour.

    -c:v libx264

With this flag, we can tell <abbr>ffmpeg</abbr> to use the libx264 encoder for the video (notice the `v` in `-c:v`?). But then, we need to give some additional options to that.

    -r 30

By default, QuickTime will record videos in 60fps. That's nice for smooth motion, but it does use up a lot of space, and for screen recordings it doesn't do anything. So with with flag, I can tell it to change the video to 30 frames per second.

    -vf scale=-1:1440

QuickTime will also record screen recordings in my native screen resolution. It looks crisp and clear, but again takes up a lot of space. With this command I recode that to 1440p, also known as 2k. You can also use `scale=-1:1080` for 1080p or `scale=-1:720` for 720p, or any resolution you like. The trick is the `-1` --- that means that ffmpeg will figure out the correct other number without distorting your video.

    -crf 25

This one is interesting. It controls the quality of the video. There are multiple methods for controlling the quality, you can set an average bitrate, you can set the minimum and maximum bitrate, or you can use this setting. The interesting thing here is that it keeps the quality constant, meaning that when the video gets more complex, it doesn't immediately get pixelated. This might not be what you want.

    -preset slow

The preset is a collection of default settings for the encoder. This specifies how much computation the encoder should use. Slower means you get better quality for the same size, but it also uses more computing power to do so. If you have a beefy machine, you can set this to `slowest`. You can get additional information about this by running `x264 --fullhelp`, if you have it installed.

    -profile:v high -level 4.0

These two settings determine how compatible the resulting video will be. From what I understand, some capabilities that result in better quality are not supported by older devices, such as the iPhone 4.

    -movflags +faststart

This is a little involved. It makes sure that the `moov` section is at the beginning of the file. From what I understand, this means that it's faster to play the file because the decoder has the information right at the beginning.

    -c:a aac

This setting determines which audio codec ffmpeg will use. In this case, I opted for aac. 

    -b:a 192k

This setting determines the bitrate to be used for the audio. Since I'm only recording voice, 192kbps is more than enough, however for music it might be better to bump this up.

    -at 48000

This makes sure that the sample rate of the audio is 48kHz. 

    -pic_fmt yuv420p

This sets the pixel encoding. From what I understand, this setting is the most sensible.

## Results

As you can see, encoding a video is not a trivial task. These settings work well for me, but they might not be ideal for other kinds of encoding tasks. 
