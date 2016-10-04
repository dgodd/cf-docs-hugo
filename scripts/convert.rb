#!/usr/bin/env ruby
require 'yaml'

# Rename
Dir["content/**/*.md.erb"].each do |fname|
  newname = fname.gsub(/\.erb$/,'')
  File.rename(fname, newname)
end
Dir["content/**/*.html.md"].each do |fname|
  newname = fname.gsub(/\.html\.md$/,'.md')
  File.rename(fname, newname)
end

Dir["content/**/*.md"].each do |fname|
  begin
    data = File.read(fname).split(/^---$/, 3)
    data.shift
    hash = YAML.load(data[0])
    name = hash["title"]
    name = identifier.gsub(/.*\//, '').capitalize if name.downcase == 'index'
    identifier = fname.gsub(/^content\//, '').gsub(/\.md/, '').gsub(/\/index$/, '')
    hash["menu"] = { "main" => { "Name" => hash["title"], "identifier" => identifier, "parent" => identifier.gsub(/[^\/]+$/,'').gsub(/\/$/,'') } }
    data[0] = YAML.dump(hash)
    data[1].gsub!(/<%= modified_date %>/, '')
    data[1].gsub!(/<strong><\/strong>/, '')
    data[1].gsub!(/\/index\.html/, '')
    data[1].gsub!(/\.html/, '')
    puts fname
    # puts "\n\n\n----------- #{fname} ---------\n"
    # puts data.join('---')
    File.write(fname, data.join('---'))
  rescue => e
    puts "----------- WOOPS ----------- #{fname} --------"
  end
end
