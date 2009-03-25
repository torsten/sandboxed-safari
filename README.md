# Sand-boxed Safari

## What? Why?

Even [Safari](http://www.apple.com/safari/) is not a 100% secure browser, [Pwn2Own](http://dvlabs.tippingpoint.com/blog/2009/03/18/pwn2own-2009-day-1---safari-internet-explorer-and-firefox-taken-down-by-four-zero-day-exploits) just demonstrated it again.  But so are all browsers, there will always be zero-day exploits.  Google's Chrome got not exploited in the contest.  Why?  Well, one reason is it uses sand-boxing.

But we love Safari, because it's Cocoa and feels like a real Mac app and stuff, right?  So lets just make Safari more secure.  Luckily Leopard provides a way to do this, it's called [sandbox-exec(1)](http://developer.apple.com/DOCUMENTATION/DARWIN/Reference/ManPages/man1/sandbox-exec.1.html#//apple_ref/doc/man/1/sandbox-exec).

This mini-project just uses Leopards bundled tools to ensure Safari can't execute other programs or write to files anywhere on the file-systems where it is not supposed to write to and this gives you way more security against exploits than a out of the box Safari has.

Even if an attacker gets into the Safari process, he will not be able to execute another process from it or write to critical file system paths to install something permanent on your system.  This doesn't protect against the all attack-vectors but against the more common ones.

All this is based on what I found in [wishi's blog post](http://wishinet.blogspot.com/2009/03/applying-sandbox-exec-around-safari.html).


## Installation

1. Grab the [tarball](http://github.com/torsten/sandboxed-safari/tarball/master) from GitHub <pre>curl -L http://github.com/torsten/sandboxed-safari/tarball/master > sandboxed-safari.tgz</pre>
2. Extract it <pre>tar vxzf sandboxed-safari.tgz</pre>
2. Switch to the directory <pre>cd torsten-sandboxed-safari&lt;TAB></pre>
3. Run the customize.rb script <pre>ruby customize.rb</pre> This will patch the policy file and the wrapper script with the locations of the files on your Mac.  You can also customize the 2 files on your own (it's not much work).  But just using the script is way more convenient.

4. Move all files to their proper locations <pre>
mv /Applications/Safari.app/Contents/MacOS/Safari /Applications/Safari.app/Contents/MacOS/Safari.orig
cp sandboxed-safari.sh /Applications/Safari.app/Contents/MacOS/Safari
cp safari-policy.sb /Applications/Safari.app/Contents/MacOS/
</pre>

5. After this, try restarting Safari and try to download a file.  If you can't save it to your home directory, everything should be working.

## Uninstall

1. Rename the original Safari executable <pre>
mv /Applications/Safari.app/Contents/MacOS/Safari.orig /Applications/Safari.app/Contents/MacOS/Safari
</pre>

2. Delete the policy file <pre>
rm /Applications/Safari.app/Contents/MacOS/safari-policy.sb
</pre>


## Limitations

I just tested it with Safari 3.2.1 (5525.27.1), I don't know how the 4.0 beta reacts to this.

In its current configuration it is not possible to download files do anywhere else than ~/Downloads/.  If you want to have this feature you can just add the line
<pre>
&#x23;"^/Users/your_user_name/"
</pre>
To the other write-allowed paths.

Also Sogudis man: URLs will not work anymore because Safari can not execute external processes anymore (whoops).  You can probably change this my adjusting the policy file as well, I just did not put any efforts into it yet.

I did not encounter any other limitations or points where Safari provides less features in any other way.
