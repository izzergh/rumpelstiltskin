# frozen_string_literal: true

require 'csv'
require_relative 'shared/pull_cldr'

UNICODE_VERSION = '16.0.0'

OUTPUT_FILE = './base_source.txt'
TEMP_FILE = './base.tmp'

SOURCE_URL = <<~URL.gsub("\n", '').freeze
  https://unicode.org/Public/
  #{UNICODE_VERSION}/
  ucd/UnicodeData.txt
URL

BAD_CODEPOINTS = [
  '000A', # Line Feed ("enter"; just inserts a blank line when puts'd)
].freeze

base_command = "curl -L #{SOURCE_URL} > #{TEMP_FILE}"
puts "pulling named unicode characters...\nrunning #{base_command}"
pull = system(base_command)

abort 'pull failed :(' unless pull

# yank CLDR data
cldr = PullCldr.new
abort 'pull failed :(' unless cldr.pull

# filters out characters (like "line feed", aka "enter" or "return")
#  that break the formatting
def too_tricky?(hex_str) = BAD_CODEPOINTS.include?(hex_str)

begin
  all_characters = Hash.new { |hash, key| hash[key] = { base: [], cldr: [] } }

  # parse the base csv
  CSV.parse(File.read(TEMP_FILE), col_sep: ';').each do |row|
    # Here's the unicode conversion. The first column is the hex codepoint.
    #
    # Ruby does not allow interpolating in the middle of a unicode literal,
    #   so I can't just do:
    #
    #   "\u{r[0]}"
    #
    # Or, I couldn't figure out how to make it work in a console.
    #
    # Instead, take the hex, turn it into a Ruby hex number, slap it in an
    #   array, and "pack" that array of one hex number into unicode.
    #
    # Bleh!
    hex_str = row[0]
    char = [hex_str.hex].pack('U')
    desc = row[1]
    desc_alternate = row[10]

    next if too_tricky?(hex_str)

    all_characters[char][:base] << desc.downcase
    all_characters[char][:base] << desc_alternate.downcase unless desc_alternate.nil?
    all_characters[char][:base] << "U+#{hex_str}"
  end

  # integrate CLDR data
  cldr.data.each do |line|
    row = all_characters[line.first]

    row[:cldr] += line.last['default']
    row[:cldr] += line.last['tts']
  end

  # write to the plugin source file
  File.open(OUTPUT_FILE, 'w') do |output_file|
    all_characters.each do |character, names|
      names_list = (names[:cldr] + names[:base]).uniq.join(' | ')
      output_file.puts "#{character} ... #{names_list}"
    end
  end

# delete temp files no matter what
ensure
  File.delete(TEMP_FILE)
  cldr.cleanup
end

puts '✓'
