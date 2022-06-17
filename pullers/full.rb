# frozen_string_literal: true

require 'csv'

OUTPUT_FILE = './full_source.txt'
TEMP_FILE = './full.tmp'

SOURCE_URL = 'https://unicode.org/Public/14.0.0/ucd/UnicodeData.txt'

BAD_CODEPOINTS = [
  '000A', # Line Feed ("enter"; just inserts a blank line when puts'd)
].freeze

command = "curl #{SOURCE_URL} > #{TEMP_FILE}"
puts "running #{command}"
pull = system(command)

abort 'pull failed :(' unless pull

# filters out characters (like "line feed", aka "enter" or "return")
#  that break the formatting
def too_tricky?(hex_str)
  BAD_CODEPOINTS.include? hex_str
end

# parse the csv and put it into the standard format for the plugin
File.open(OUTPUT_FILE, 'w') do |output_file|
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

    point = "#{char} ... #{desc}"
    point += " | #{desc_alternate}" unless desc_alternate.nil?
    point += " | U+#{hex_str}"

    output_file.puts point
  end
end

File.delete(TEMP_FILE)
