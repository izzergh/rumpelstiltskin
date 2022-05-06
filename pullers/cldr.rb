# frozen_string_literal: true

OUTPUT_FILE = './cldr_source.txt'
TEMP_FILE = './cldr.tmp'

SOURCE_BRANCH = 'main'
SOURCE_URL = "https://raw.githubusercontent.com/unicode-org/cldr-json/#{SOURCE_BRANCH}/cldr-json/cldr-annotations-full/annotations/en/annotations.json"

JQ_ARG = <<~ARG.gsub("\n", ' ')
  .annotations.annotations
  | .[] |= (reduce .["default"][] as $x (""; . + " | " + $x))
  | to_entries[]
  | reduce . as {key: $a, value: $b} (""; . + $a + " ..." + $b)
ARG

# Download and parse the source
command = "curl #{SOURCE_URL} | jq '#{JQ_ARG}' > #{TEMP_FILE}"
puts "running #{command}"
pull = system(command)

abort 'pull failed :(' unless pull

# Move the source and trim the quotation marks left by jq
File.open(OUTPUT_FILE, 'w') do |output_file|
  File.readlines(TEMP_FILE).each do |line|
    output_file.puts line.gsub(/^"/, '').gsub(/"$/, '')
  end
end

File.delete(TEMP_FILE)
