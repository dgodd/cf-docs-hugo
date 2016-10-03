#!/usr/bin/env ruby

## Rename
Dir["content/**/*.md.erb"].each do |fname|
  newname = fname.gsub(/\.erb$/,'')
  File.rename(fname, newname)
end
Dir["content/**/*.html.md"].each do |fname|
  newname = fname.gsub(/\.html\.md$/,'.md')
  File.rename(fname, newname)
end

Dir["content/**/*.md"].each do |fname|
  data = File.read(fname)
  data.gsub!(/<%= modified_date %>/, '')
  File.write(fname, data)
end
