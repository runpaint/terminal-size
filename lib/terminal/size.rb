# Much of the operating-system-specific code is this library is taken from
# the Ruby Cookbook, by Lucas Carlson and Leonard Richardson. Copyright
# 2006 O’Reilly Media, Inc., 0-596-52369-6. The books front matter states: "
# In general, you may use the code in this book in your programs and 
# documentation. You do not need to contact us for permission unless you’re
# reproducing a significant portion of the code. For example, writing a 
# program that uses several chunks of code from this book does not require
# permission."
                                             
class TerminalSize
  attr_accessor :rows, :cols
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
  def valid?
    [self.rows, self.cols].all? {|d| d.is_a? Integer}
  end
end
class TerminalSize::UnknownOS < StandardError
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
  def initialize
    @message = "The size of your terminal could not be determined."
    $stderr.puts @message
  end
end   
