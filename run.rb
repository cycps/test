#!/usr/bin/env ruby

require 'optparse'
require 'erb'

`mkdir -p env`
`mkdir -p .test`

@cydata = File.expand_path("./.test/data")
@cyaddie = File.expand_path("./.test/addie")

genonly = false

options = {}
OptionParser.new do |opts|
  opts.banner = 'usage: run.rb'
  
  opts.on('--data [dir]', String, "cycps/data source directory") do |dir| 
    @cydata = File.expand_path(dir) 
  end

  opts.on('--addie [dir]', String, "cycps/addie source directory") do |dir| 
    @cyaddie = File.expand_path(dir)
  end

  opts.on('--genonly', "only generate the vagrant file, do not launch environment") do |dir|
    genonly = true
  end

end.parse!

system(
  "git clone git@github.com:cycps/data #{@cydata}"
) unless File.exist?(@cydata)

system(
  "git clone git@github.com:cycps/addie #{@cyaddie}"
) unless File.exist?(@cyaddie)


erb = ERB.new(File.read('Vagrantfile.erb'))
File.write('env/Vagrantfile', erb.result())

if !genonly
  Dir.chdir "env"
  system('vagrant up')
end

