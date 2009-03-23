#!/usr/bin/env ruby
# Customizes the files of sandboxed-safari to work with your setup.
# Copyright (C) 2009 Torsten Becker <torsten.becker@gmail.com>

policy_file    = 'safari-policy.sb'
wrapper_script = 'sandboxed-safari.sh'

home = ENV['HOME']
raise "Can't detect home-directory"  if home.nil?

ss_path = File.expand_path(File.dirname(__FILE__))


patched_policy = File.open(policy_file, 'rb') do |file|
  file.readlines.join.gsub(/HOME/, home)
end

patched_wrapper = File.open(wrapper_script, 'rb') do |file|
  file.readlines.join.gsub(/SS_PATH/, ss_path)
end


File.open(policy_file, 'wb') do |file|
  file.write patched_policy
end

File.open(wrapper_script, 'wb') do |file|
  file.write patched_wrapper
end


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
