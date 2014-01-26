#!/usr/bin/env ruby
# encoding: utf-8

keyword   = ARGV[0]
directory = ARGV[1]
keyword2  = ARGV[2]

if [keyword, directory, keyword2].any? {|s| s == nil || s == "" }
  puts "grep_by_grep.rb [keyword] [directory] [keyword2]"
  exit
end

grep_result = `grep '#{ keyword.gsub(/\\/, "\\\\") }' -R #{ directory }`.split(/\n/)
file_paths = grep_result.map {|line| if m = line.match(/^(.*)?: /) then m[1] else nil end }.reject(&:nil?).uniq

file_paths.each do |file_path|
  grep_result2 = `grep '#{ keyword2.gsub(/\\/, "\\\\") }' #{ file_path } -n`.split(/\n/)
  unless grep_result2.empty?
    puts "\n#{ file_path }"
    grep_result2.each do |line|
      puts line
    end
  end
end




