---
layout: post
title:  Exploring APFS
date:   2018-09-15
summary: "File systems are fascinating and scary. When I heard that Apple was working on its own in 2016, I was immediately interested. In this post, I will take a look at this file system and see what it's all about, and explore some of the new features that it brings to the table."
---

File systems are fascinating and scary. When I heard that Apple was working on its own [in 2016][ArsTechnica], I was immediately interested. Now, in 2018, <abbr title="Apple Filesystem">APFS</abbr> is standard on both macOS and iOS.

Why are filesystems so interesting? With [<abbr title="File System in Userspace">FUSE</abbr>][FUSE], anyone can implement their own filesystem. But these run in userspace, where things are slower but protected from programming errors[^1]. Real file systems run in kernelspace[^2], and that is where things get interesting because programming errors can crash the system[^3]. But much worse than crashing a system, an error could also cause corruption or loss of data. With that in mind, it becomes apparent that file system authors are incredibly talented people[^4]. 

## Motivations

Before <abbr>APFS</abbr>, Apple used [<abbr title="Hierarchical File System Plus">HFS+</abbr>][HFSPlus], which was introduced in 1998 as an extension of [<abbr title="Hierarchical File System">HFS</abbr>][HFS], and that in turn was introduced in 1985. Both of these were designed for storage media like hard drives.[^hfs-floppy]

So what is so special about hard drives? These work similar to an old record player: they have rotating disks (usually multiple stacked on top of each other) with a round track consisting of the data, and they have a pickup that can move to follow the track or jump to another position.

![Harddrive front](/assets/images/harddrive-front.svg){:width="20%"}

These kinds of storage media are really good at reading and writing sequential data. That means that when you read a file from beginning to end, the speed is quite good. However, if you jump around, reading bits and pieces from different places, the performance rapidly deteriorates. This is because the reading head has to physically move and find whatever you are looking for.

File systems designed for these kinds of storage media have some very specific contstraints. For example, they might try not to split up files. Maybe they will try to put files that are accessed frequently close to another, so that they can be accessed faster. All of these optimizations are built on knowledge of how hard drives work internally.

![Samsung SSD](/assets/images/samsung-ssd.jpg){:width="80%"}

All was going well for file system architechts and implementors, until the <abbr title="Solid State Drive">SSD</abbr> took on a major role in personal computing. As the name *solid state drive* suggests, the main difference between regular hard drives is that it doesn't have any moving parts.

As such, it has different properties that file system implementors need to watch out for. For once, when accessing data, there is almost no different between sequential and random access, meaning that the speed is the same if you read a file from beginning to end as if you access small bits in a random order. But the one issue is that <abbr>SSD</abbr>s have a limited life span, because the individual memory cells that it is made up of can only take so many writes.

When Apple was designing <abbr>APFS</abbr>, one of the reasons behind that was that they designed it from the ground up to work well with <abbr>SSD</abbr> storage, which is now more common than traditional hard drives. While it is possible to add <abbr>SSD</abbr> support to existing file systems, for example by adding support for the [<abbr title="A command used to inform an SSD drive that a block of memory is no longer used and can be wiped internally">TRIM</abbr> command][TRIM], it is easier to just start from scratch.

In fact, Apple themselves say:

>   Apple File System is uniquely designed to meet the needs of Apple’s products and ecosystem. Apple File System provides strong encryption, ultra-low latencies and limited memory overhead. It is optimized for flash/<abbr>SSD</abbr> storage and can be used on everything from an Apple Watch to a Mac Pro.
>   
>   <abbr>HFS+</abbr> and its predecessor <abbr>HFS</abbr> are more than 30 years old. These file systems were developed in an era of floppy disks and spinning hard drives, when file sizes were calculated in kilobytes or megabytes.
>   
>   Today, people commonly store hundreds of gigabytes and access millions of files on high-speed, low-latency flash drives. People carry their data with them, and they demand that sensitive information be secure.[^apple-apfs]

## Features

<abbr>APFS</abbr> is a pragmatic successor to the previous <abbr>HFS+</abbr> in that it doesn't add anything crazy, but it does have some useful bits and pieces that we can look at in detail.

- **Encryption** support lets your protect your data safe from prying eyes, unless they have the password.
- It is possible to take **snapshots** of the state of the file system. This means that you can save the current state of your file system without having to do a full backup. This feature is actually used by Time Machine.
- It supports **clones** of files. This means that when copying large files, they don't actually need to be copied, but both files (clones) will point to the same data. When you then edit one of them, the file system only needs to record the changes.
- On a single *container* (think hard drive or partition), you can have multiple *volumes* sharing the same space. This is like partitioning a hard drive, but instead of having to specify the sizes beforehand, they all share the same space, so you can divit it up as you like.

### Encryption

When you create a new <abbr>APFS</abbr>-formatted volume, you have the option of creating an regular or and encrypted volume. For the latter, you just need to enter a password that you will need to remember because you will have to enter it every time you mount your volume, unless you allow your computer to save it in your keychain.

![Creating an APFS-formatted encrypted volume](/assets/images/apfs-creating-encrypted.png)

This is not exactly different from the process of creating an encrypted <abbr>HFS+</abbr> volume. I think that the only difference is internally---with <abbr>HFS+</abbr> volumes, the encryption was apparently a little more hackish[^imore-apfs].

### Space sharing

Space sharing means that if you have an <abbr>APFS</abbr>-formatted drive, you can create multiple volumes on it that share the same space. This is very similar to having multiple partitions on a single drive, with one crucial difference: with partitions, you have to specify their size when you create them, and it is not easy to change their size (grow or shrink them). With space sharing, multiple volumes share the same container, and they can use as much of that container as they like until it is full.

Disk utility has two buttons that can be used to add and remove volumes from an <abbr>APFS</abbr> container. Each volume is like a separate file system, so you can have multiple volumes, some with different encryption keys and some with no encryption.

![Adding a volume to an APFS-formatter container](/assets/images/apfs-adding-volume.png)

It is even possible to specify some constraints, like reserving a minimum amount of space for a given volume or limiting its maximum size.

![APFS volume size options](/assets/images/apfs-volume-size-options.png)

This is a really awesome feature, and I think all file systems should allow this. There are some solutions that allow this, like <abbr title="Logical Volume Manager">LVM</abbr> or some file system that natively support it, like <abbr>ZFS</abbr>. The only possible downside is that if the file system was corrupted, it could affect all volumes on it, instead of just one as with partitioning. But that scenario is very hypothetical, and it won't keep me from using this awesome new feature.

### Clones

Apple has a nice overview of some of the new features, including the clone mechanism.[^apfs-overview] Testing the clone facility is quite easy, if you simply copy something in finder, you will see the result: it is possible to copy a large file, say a 2<abbr>GB</abbr> movie, an obscene amount of times almost instantly.

![APFS clone illustrated on some movies](/assets/images/apfs-clone-movie.png)

This feature is not without criticism. It does not work when you use `cp` in the terminal, for example, because you need to use Apple <abbr>API</abbr>s to access it. Also, it might not be overly useful since most programs will completely rewrite files when modifying them[^apfs-in-etail].

### Snapshots

This is the one feature that I haven't been able to play around with too much yet, unfortunately. I've seen that it is actively used on my system, and I can list which snapshots exist using the `tmutil` tool.

    $ tmutil listlocalsnapshots /
    com.apple.TimeMachine.2018-09-15-141751
    com.apple.TimeMachine.2018-09-17-214432
    com.apple.TimeMachine.2018-09-17-224235
    com.apple.TimeMachine.2018-09-17-234536
    com.apple.TimeMachine.2018-09-18-004444
    com.apple.TimeMachine.2018-09-18-192237

From what I understand, snapshots are used before installing apps or updates to create a "known-good" point to get back to in case things get hairy. Apparently, it is also possible to mount them. But I will save this for another article on another day!

## Issues

The interesting thing with file systems is that they are good when you don't notice them. They are there to store your data, and you should never have to directly interact with them. As long as they keep your data, all is good. As soon as they throw error messages at you, or corrupt your data, you know that something in going wrong. 

I haven't encountered any issues with <abbr>APFS</abbr>, and I don't think I will. It seems like a stable product, and since it is used by default on all new macOS installations and on iPhones as well, I'm sure it receives a huge amount of testing to make sure it runs well.

The only issue is that any applications that rely on specific filesystem features need to be adjusted. And that is the only area where I've run into an issue.

### Time Machine

Currently, Time Machine only supports storing its backups on <abbr>HFS+</abbr>-formatted volumes. When you have an <abbr>APFS</abbr>-formatted drive mounted and you try to switch to it, it will not show up in the Time Machine preference pane.

![](/assets/images/apfs-time-machine-preferences.png)

I am very sure that this issue will be fixed very quickly, as I presume that Apple wants to switch all <abbr>HFS+</abbr> volumes over to <abbr>APFS</abbr> soon, since they probably don't want to support both file systems indefinitely.

But in the meantime, there is a workaround that is not pretty but it works for me. I basically created a disk image by pressing <kbd>&#8984;</kbd>N in Disk Utility (File &rarr; New Image &rarr; Blank Image). I selected the *sparse bundle disk image*, which is an image that only takes up as much space as it actually uses, gave it a descriptive name, set the size to 500<abbr title="Gigabytes">GB</abbr> which should be plenty for my backups, and selected *Mac OS Extended (Journaled)* as the file system instead of the default <abbr>APFS</abbr>. This is important.

![APFS Time Machine disk image](/assets/images/apfs-time-machine-disk-image.png)

Next, you need to make sure that the disk image is mounted. All you need to do to convince Time Machine to use it as backup disk is use the command-line tool `tmutil`. If you named your volume something else than "Time Machine", you'll have to change that in the command obviously.

    sudo tmutil setdestination "/Volumes/Time Machine"

## Conclusion

So far, I think that <abbr>APFS</abbr> is a very neat and stable system. I think it has some nice features, but it doesn't go overboard resulting in a theoretically cool, but practically unstable file system. 


[TRIM]: https://en.wikipedia.org/wiki/Trim_(computing)
[HFS]: https://en.wikipedia.org/wiki/Hierarchical_File_System
[HFSPlus]: http://ntfs.com/hfs.htm
[ArsTechnica]: https://arstechnica.com/gadgets/2016/06/new-apfs-file-system-spotted-in-new-version-of-macos/
[Reiser]: https://en.wikipedia.org/wiki/Hans_Reiser
[FUSE]: https://github.com/libfuse/libfuse
[^1]: It's a little more complicated than that, I know.
[^2]: Unless your operating system uses a microkernel. But that's very unlikely.
[^3]: VirtualBox, for example, uses a kernel module that manages to crash my macOS occasionally. 
[^4]: Unless they are [currently in jail][Reiser], I suppose. 
[^hfs-floppy]: Actually, it would have also been designed with floppy disks in mind. Do you still remember those? Crazy how fast storage technology moves.
[^imore-apfs]: See <https://www.imore.com/apfs>
[^apple-apfs]: See [Apple <abbr>APFS</abbr> <abbr>FAQ</abbr>](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/APFS_Guide/FAQ/FAQ.html)
[^apfs-overview]: See [Apple <abbr>APFS</abbr> overview](https://developer.apple.com/documentation/foundation/file_system/about_apple_file_system#overview)
[^apfs-in-etail]: See Adam Leventhal's excellent article [<abbr>APFS</abbr> in Detail](http://dtrace.org/blogs/ahl/2016/06/19/apfs-part1/)
