#!/usr/bin/env ruby
# Customizes the files of sandboxed-safari to work with your setup.

puts ENV['HOME']



next_steps = <<EOM
Next steps:

Rename Safari executable:
  mv /Applications/Safari.app/Contents/MacOS/Safari \\
    /Applications/Safari.app/Contents/MacOS/Safari.orig

Copy the wrapper script there instead of the real Safari:
  cp sandboxed-safari.sh \\
    /Applications/Safari.app/Contents/MacOS/Safari

Relaunch Safari:
  killall Safari
  open -a Safari

EOM

puts next_steps
