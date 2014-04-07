task :default => [:test]

task :test do
  system 'ruby "test/ts_fuzzy-date.rb" >> /dev/null'
  puts 0 if $? == 0
end