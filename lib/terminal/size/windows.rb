class TerminalSize  
  STDOUT_HANDLE = 0xFFFFFFF5
  def initialize
    super
  end  
  def get
    m_GetStdHandle = Win32API.new('kernel32', 'GetStdHandle', ['L'], 'L')
    m_GetConsoleScreenBufferInfo = Win32API.new('kernel32',
                                                  'GetConsoleScreenBufferInfo',
                                                  ['L', 'P'], 'L' )
    format = 'SSSSSssssSS'
    buf = ([0] * format.size).pack(format)
    stdout_handle = m_GetStdHandle.call(STDOUT_HANDLE)
    m_GetConsoleScreenBufferInfo.call(stdout_handle, buf)
    (bufx, bufy, curx, cury, wattr,
      left, top, right, bottom, maxx, maxy) = buf.unpack(format)
    self.rows, self.cols = bottom - top + 1, right - left + 1
    raise FailedToGetSize unless self.valid?
  end
end    

