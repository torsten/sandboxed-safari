# Sand-boxed Safari

## What? Why?

Safari is one of the most insecure browsers, [Pwn2Own](http://dvlabs.tippingpoint.com/blog/2009/03/18/pwn2own-2009-day-1---safari-internet-explorer-and-firefox-taken-down-by-four-zero-day-exploits) just demonstrated it again.  But so are all browsers, there will always be zero-day exploits.  Google's Chrome got not exploited in the contest.  Why?  Well, one reason is, it uses sand-boxing.

But we love Safari, because it's Cocoa and feels like a real Mac app and stuff, right?  So lets just make Safari more secure.  Luckily Leopard provides a way to do this, it's called [sandbox-exec(1)](http://developer.apple.com/DOCUMENTATION/DARWIN/Reference/ManPages/man1/sandbox-exec.1.html#//apple_ref/doc/man/1/sandbox-exec).

This mini-project just uses Leopards bundled tools to ensure Safari can not execute other programs or write to files anywhere on the file-systems where it is not supposed to write to and this gives way more security against exploits than a out of the box Safari has.

Want to read more details or hear about some limitations? Just scroll down&hellip;


## Installation

1. Grab the tarball from [github](http://)
2. Extract it <pre>$ tar vxzf ...</pre>
3. Run the customize.rb script <pre>$ ruby customize.rb</pre> This will patch the policy file and the wrapper script with the locations of the files on your Mac.
4. Do what it says <pre>
$ mv /Applications/Safari.app/Contents/MacOS/Safari \
  /Applications/Safari.app/Contents/MacOS/Safari.orig
$ cp sandboxed-safari.sh \
  /Applications/Safari.app/Contents/MacOS/Safari
</pre>
5. After this, try restarting Safari and download a file.  If you can not download it to your home directory, everything should be working.


## Limitations

In its current configuration it is not possible to download files do anywhere else than ~/Downloads/.  If you want to have this feature you can just add the line
<pre>
#"^/Users/your_user_name/"
</pre>
To the other write-allowed paths.

Also Sogudis man: URLs might not work anymore because Safari can not execute external processes anymore (whoops).  You can probably change this my adjusting the policy file as well, I just did not put any efforts into it yet.

I did not encounter any other limitations or points where Safari provides less features in any other way.


## The boring details

This is a set of files which allows you to sandbox Safari.  Browsers are complex software and no browser will probably ever be bug-free, thats why Google Chrome introduced sand-boxing for its rendering process.

But Chrome is not available for the Mac yet and you want to have more security nevertheless, right?  (Cause you are paranoid, right?)

This stuff is based on http://wishinet.blogspot.com/2009/03/applying-sandbox-exec-around-safari.html
the basic idea is to use Leopards sandbox(3)...


do shell script "sandbox-exec -f /Users/wishi/policies/sandbox-safari.sb /Applications/Safari.app/Contents/MacOS/Safari"






<pre>
(version 1)
(debug deny) ; Use (debug all) to see every action)
(allow network-outbound)
(allow signal)
(allow ipc-posix-shm) ; Needed for POSIX shared memory
;(allow process-exec (regex #"^/Applications/Safari.app/*"))
(allow sysctl-read)
(allow file-read-metadata)
(allow signal)
(allow process*)
;(allow mach*)
(allow mach-lookup)
;(allow process-exec (regex "^/System/Library/CoreServices/*"))
;; Allow to read these files:
(allow file-read*
(regex
#"^/Users/wishi/$"
#"^/Users/wishi/Downloads"
#"^/Users/wishi/Library"
#"^/Users/wishi/Public"
#"^/Users/wishi/Sites"
#"^/Applications/Safari.app"
#"^/Library/*"
#"^/System/Library/*"
#"^/usr/lib/*"
#"^/usr/share/*"
#"^/private/*"
#"^/dev/*"
)
)
;; Allow to write these files:
(allow file-write*
(regex
#"^/Users/wishi/Downloads/*"
#"^/Volumes/foo/bar/*"
#"^/Users/wishi/Library/.*"
#"^/private/var/*"
#"^/dev/dtracehelper"
)
)
(deny default)
</pre>