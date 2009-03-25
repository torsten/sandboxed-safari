#!/usr/bin/env ruby
# Customizes the files of sandboxed-safari to work with your setup.
# Copyright (C) 2009 Torsten Becker <torsten.becker@gmail.com>

policy_file = 'safari-policy.sb'

home = ENV['HOME']
raise "Can't detect home-directory"  if home.nil?

# Call with revert as single argument to create the default policy
if $*.size == 1 and $*[0] == 'revert'
  a, b = home, 'HOME'
else
  a, b = 'HOME', home
end


patched_policy = File.open(policy_file, 'rb') do |file|
  file.readlines.join.gsub(a, b)
end

File.open(policy_file, 'wb') do |file|
  file.write patched_policy
end


next_steps = <<EOM
Next steps:

Rename Safari executable:
  mv /Applications/Safari.app/Contents/MacOS/Safari \\
    /Applications/Safari.app/Contents/MacOS/Safari.orig

Copy the wrapper script there instead of the real Safari:
  cp sandboxed-safari.sh \\
    /Applications/Safari.app/Contents/MacOS/Safari

Copy the policy file to Safaris bundle as well:
  cp safari-policy.sb \\
    /Applications/Safari.app/Contents/MacOS/


Relaunch Safari:
  killall Safari
  open -a Safari

EOM

puts next_steps
