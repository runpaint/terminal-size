
    require 'rubygems'
    require 'terminal/size'
    size = TerminalSize.new
    puts "Your terminal has #{size.rows} rows and #{size.cols} columns".

This is a simple library to find the dimensions of the terminal it is running
on. Dimensions are useful, for example, when deciding how to format text that
is to be displayed on a terminal, or for determining when output should be
piped to the user's pager.

In theory, this library should work on Linux, FreeBSD, Mac OS, and Windows,
but I have only tested it on Linux. If you run it one of these other
platforms, please let me know what happened.
