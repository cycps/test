#!/usr/bin/env ruby

require 'optparse'
require 'erb'

`mkdir -p env`
`mkdir -p .test`

@cydata = "./.test/data"
@cyaddie = "./.test/addie"

options = {}
OptionParser.new do |opts|
  opts.banner = 'usage: run.rb'
  
  opts.on('--data [dir]', String, "cycps/data source directory") do |dir| 
    @cydata = File.expand_path(dir) 
  end

  opts.on('--addie [dir]', String, "cycps/addie source directory") do |dir| 
    @cyaddie = File.expand_path(dir)
  end

end.parse!

system(
  'git clone git@github.com:cycps/data #{ENV["CYDATA"]}'
) unless File.exist?(@cydata)

system(
  'git clone git@github.com:cycps/data #{ENV["CYADDIE"]}'
) unless File.exist?(@cyaddie)


erb = ERB.new(File.read('Vagrantfile.erb'))
File.write('env/Vagrantfile', erb.result())

Dir.chdir "env"
system('vagrant up')

