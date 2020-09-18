#\ -s puma -O Threads=0:16 -O Verbose=true

require './config/environment'

run App.new
