class TerminalSize
  # Ideally we'd derive the architecture from RUBY_PLATFORM, but there
  # doesn't seem to be any standard way of doing this. Thus, we assume that
  # Mac's use PowerPC, and everybody else uses Intel. However, if our first
  # choice doesn't work, we try the second. 
  TIOCGWINSZ = {'Intel' => 0x5413, 'PowerPC' => 0x40087468}
  def initialize
    super
  end
  def get
    raise NotATTY unless $stdout.tty?
    %w{ioctl stty}.each do |source|
      self.send("from_#{source}")
      return if self.valid?
    end  
    raise FailedToGetSize
  end  
  def from_ioctl
    rows, cols = 25, 80 #TODO: Use this as standard size?
    buf = [ 0, 0, 0, 0 ].pack("SSSS")
    arch = %w{Intel PowerPC}
    arch.reverse! if RUBY_PLATFORM.match(/powerpc/)
    arch.each do |a|
      begin
        if STDOUT.ioctl(TIOCGWINSZ[a], buf) >= 0 then
          self.rows, self.cols = buf.unpack("SSSS")[0..1][0..1]
        end
      rescue Errno::EINVAL
        next
      end  
      break if self.valid?
    end
  end  
  def from_stty
    self.rows, self.cols = %x{stty size}.split.collect { |x| x.to_i }
  end
end
