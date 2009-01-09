require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

desc "Run the test suite"
task :default => :test

desc "Test the enterprise_time_extensions gem."
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
