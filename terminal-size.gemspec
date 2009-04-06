# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{terminal-size}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Run Paint Run Run"]
  s.date = %q{2009-04-06}
  s.email = %q{runrun@runpaint.org}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "examples/termsize",
    "lib/terminal/size.rb",
    "lib/terminal/size/unix.rb",
    "lib/terminal/size/windows.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/runpaint/terminal-size}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Determines the dimensions of the user's terminal}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
