# frozen_string_literal: true

require 'csv'
require_relative 'shared/pull_cldr'

UNICODE_VERSION = '15.1'

OUTPUT_FILE = './emoji_source.txt'
TEMP_FILE = './emoji.tmp'

SOURCE_URL = <<~URL.gsub("\n", '').freeze
  https://unicode.org/Public/emoji/#{UNICODE_VERSION}/emoji-test.txt
URL

command = "curl -L #{SOURCE_URL} > #{TEMP_FILE}"
puts "running #{command}"
pull = system(command)

abort 'pull failed :(' unless pull

# yoink CLDR data
cldr = PullCldr.new
abort 'pull failed :(' unless cldr.pull

def ignore?(line)
  # skip blank lines
  return true if line.strip.empty?

  # skip comments without data this script uses
  line.start_with?('#') && !subgroup_comment?(line)
end

def subgroup_comment?(line)
  line.start_with?('# subgroup:')
end

# Hashify the emoji list
all_characters = Hash.new do |hash, key|
  hash[key] = { name: '', cldr: [], group: '' }
end

current_group = ''
File.open(TEMP_FILE, 'r').each do |input_line|
  next if ignore?(input_line)

  if subgroup_comment?(input_line)
    current_group = input_line.split(' ').last
    next
  end

  emoji, name = input_line.split(' # ').last.split(/\sE\d{1,}\.\d{1,}\s/)
  all_characters[emoji][:name] = name
  all_characters[emoji][:group] = current_group
end

# Integrate CLDR data
cldr.data.each do |line|
  # only append to emoji, do not add new entries from CLDR
  next unless all_characters.key?(line.first)

  row = all_characters[line.first]

  row[:cldr] += line.last['default']
  row[:cldr] += line.last['tts']
end

# Populate source file
File.open(OUTPUT_FILE, 'w') do |output_file|
  all_characters.each do |emoji, names|
    names_list = ([names[:name].strip] + names[:cldr]).uniq.join(' | ')
    output_file.puts <<~LINE
      #{emoji} ... #{names_list} (#{names[:group].strip})
    LINE
  end
end

# clean up temp files
File.delete(TEMP_FILE)
cldr.cleanup

puts '✓'
