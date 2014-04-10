$:.unshift File.expand_path('../lib', __FILE__)
require 'fuzzy-date'

Gem::Specification.new do |s|
  s.name        = 'fuzzy-date'
  s.version     = FuzzyDate::VERSION
  s.authors     = [ 'David Cole' ]
  s.email       = [ 'david.cole@digitalcharleston.com' ]
  s.summary     = 'fuzzy-date provides a way to use partial and incomplete dates.'
  s.homepage    = 'https://github.com/davidcole/fuzzy-date'
  s.description = 'The fuzzy-date gem provides a way to parse and use incomplete dates, like those found in history or genealogy.'
  s.files       = [ "README.md", "LICENSE", "demo.rb", "lib/fuzzy-date.rb" ]
  s.license     = 'MIT'
end
