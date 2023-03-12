# frozen_string_literal: true

require 'json'

# Object that pulls and stores the CLDR data.
# Shared among rake tasks.
# The CLDR (Common Locale Data Repository) is a resource maintained by Unicode
#   for the purpose of providing canonical names for unicode codepoints in
#   various languages.
# For the purposes of this plugin, the CLDR is used to aid in making the fuzzy
#   search more fuzzy. By adding nicknames to codepoints, the user has more
#   leeway in searching by "vibe".
# Currently, only English is supported. If I can think of a resource-light
#   way of doing the same for the other languages in the CLDR, I will. Only
#   supporting one language doesn't sit right with me, either.
class PullCldr
  TEMP_FILE = './cldr.tmp'
  CLDR_VERSION = '42.0.0'

  SOURCE_URL = <<~URL.gsub("\n", '').freeze
    https://raw.githubusercontent.com/unicode-org/cldr-json/
    #{CLDR_VERSION}/
    cldr-json/cldr-annotations-full/annotations/en/annotations.json
  URL

  # curls down the CLDR. Returns true if successful, false otherwise.
  # This is idempotent - the file is overwritten with each pull.
  def pull
    cldr_command = "curl -L #{SOURCE_URL} > #{TEMP_FILE}"
    puts "pulling cldr characters...\nrunning #{cldr_command}"
    system(cldr_command)
  end

  # Parses the pulled CLDR. Assumes the CLDR is in JSON format.
  # The resulting object is a Hash with the following structure:
  # {
  #   'SEQ' => {
  #       'default' => ['nick1', 'nick2', 'nick3']
  #       'tts' => ['nick4', 'nick5']
  #     }
  # }
  #
  # SEQ is the character sequence, and 'nickX' is a nickname for that character
  #   sequence. 'tts' stands for 'text to speech', and I'm guessing is meant
  #   for use with TTS software. For us it is just some more nicknames.
  def data
    @data ||= JSON.parse(File.read(TEMP_FILE))['annotations']['annotations']
  end

  # Delete the temp file!
  def cleanup
    FileUtils.rm(TEMP_FILE)
  end
end
