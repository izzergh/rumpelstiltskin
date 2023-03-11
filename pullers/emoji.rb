# frozen_string_literal: true

require 'csv'

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

def ignore?(line)
  # skip blank lines
  return true if line.strip.empty?

  # skip comments without data this script uses
  line.start_with?('#') && !subgroup_comment?(line)
end

def subgroup_comment?(line)
  line.start_with?('# subgroup:')
end

# parse the csv and put it into the standard format for the plugin
File.open(OUTPUT_FILE, 'w') do |output_file|
  current_group = nil

  File.open(TEMP_FILE, 'r').each do |input_line|
    next if ignore?(input_line)

    if subgroup_comment?(input_line)
      current_group = input_line.split(' ').last
      next
    end

    emoji, name = input_line.split(' # ').last.split(/\sE\d{1,}\.\d{1,}\s/)
    output_file.puts <<~LINE
      #{emoji} ... #{name.strip} (#{current_group.strip})
    LINE
  end
end

File.delete(TEMP_FILE)

puts '✓'
