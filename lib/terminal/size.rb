
# = Introduction
# TerminalSize is a library for finding the dimensions of the terminal a pRuby
# program is running on.
#
# = Using TerminalSize
# Just require 'terminal/size', create a TerminalSize object, then call the
# rows method to find the number of rows the terminal has, and the cols method
# to find the number of columns.
#
#    require 'rubygems'
#    require 'terminal/size'
#    size = TerminalSize.new
#    puts "Your terminal has #{size.rows} rows and #{size.cols} columns"
#    
# Author:: Run Paint Run Run <runrun@runpaint.org>
# License:: GPL v.3
# Version:: 0.0.1
#
# = Attribution
# Much of the operating-system-specific code is this library is taken from
# the Ruby Cookbook, by Lucas Carlson and Leonard Richardson. Copyright
# 2006 O'Reilly Media Inc., 0-596-52369-6. The books front matter states:
# "In general, you may use the code in this book in your programs and 
# documentation. You do not need to contact us for permission unless you're
# reproducing a significant portion of the code. For example, writing a 
# program that uses several chunks of code from this book does not require
# permission."
class TerminalSize
  # Returns an integer corresponding to the dimension of the user's terminal.
  attr_accessor :rows, :cols
  # Create a new TerminalSize object, determine the dimensions of the current
  # terminal.
  def initialize
    @rows, @cols = nil, nil
    file = case RUBY_PLATFORM
      when /mswin/                   :'windows'
      when /(powerpc|linux|freebsd)/ :'unix'
      else raise UnknownOS
    end
    require File.join(File.expand_path(__FILE__).sub(/\.rb$/,''), file)
    self.get
  end
  # Are the dimensions which have been found at least vaguely sane? Returns
  # true if they are; false otherwise.
  def valid?
    [self.rows, self.cols].all? {|d| d.is_a? Integer}
  end
end
class TerminalSize::UnknownOS < StandardError
# Exception thrown if the user's operating system cannot be determined. 
#
# The code to determine terminal dimensions is operating-system specific, so
# without this information we cannot proceed. 
  def initialize
    @message = <<MSG
Your operating system could not be determined from the RUBY_PLATFORM value, 
which your system reports as #{RUBY_PLATFORM}. This library is only intended
to work on Linux, Mac OS, FreeBSD, and Windows systems. If you're using a 
different operating system and know how to determine the terminal size,
please send a patch.
MSG
  $stderr.puts @message
  end
end 
class TerminalSize::FailedToGetSize < StandardError
# Exception thrown if the dimensions of the user's terminal could not be
# determined by any strategy we know.  
  def initialize
    @message = "The size of your terminal could not be determined."
    $stderr.puts @message
  end
end   
