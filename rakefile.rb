require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'rake/clean'
require 'flashsdk'
require 'asunit4'


desc "Build the swf"
task :clean_run do
  Rake::Task["build"].invoke
end

##############################
# Debug

desc "Compile the prod swf"
task :build => "bin/flashcanvas.swf"

# Compile the debug swf
mxmlc "bin/flashcanvas.swf" do |t|
  t.input = "src/FlashCanvas.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :run => "bin/flashcanvas.swf"


##############################
# DEFAULT
task :default => :run

