task :test do
  $:.unshift './test'
  Dir.glob('test/ts_*.rb').each { |t| require File.basename(t) }
end

task :default => :test

def version
  contents = File.read File.expand_path('../lib/fuzzy-date.rb', __FILE__)
  contents[/VERSION = "([^"]+)"/, 1]
end

desc "Release FuzzyDate version #{version}"
task :release => :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "git commit --allow-empty -am 'Release #{version}.'"
  sh "git tag v#{version}"
  sh "git push origin master"
  sh "git push origin v#{version}"
  sh "gem push fuzzy-date-#{version}.gem"
end

desc "Build a gem from the gemspec"
task :build do
  sh "gem build fuzzy-date.gemspec"
end