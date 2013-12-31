Gem::Specification.new do |s|
  s.name        = 'ruby_ttt'
  s.version     = '0.4.3'
  s.summary     = "Tic-tac-toe game with computer player AI option."
  s.description = "A tic-tac-toe game with human vs. human, human vs. computer, and computer vs. computer options. When 'hard' level is selected, the computer is unbeatable and the AI uses the minimax algorithm."
  s.authors     = ["Taryn Sauer"]
  s.email       = 'tsauer@8thlight.com'
  s.homepage    = 'http://rubygems.org/gems/ruby_ttt'

  s.add_development_dependency "rspec"

  s.files       = Dir.glob("{lib, spec}/**/*")
  s.require_path = 'lib'
end