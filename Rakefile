# frozen_string_literal: true

desc 'Pull and update all source files'
task :pull_all do
  Rake::Task['pull_cldr'].invoke
  Rake::Task['pull_full'].invoke
  Rake::Task['pull_emoji'].invoke
end

namespace :check do
  desc 'check for jq binary'
  task :jq do
    puts 'checking for jq...'
    abort('install jq and try again') unless system('which jq')
  end

  desc 'check for curl binary'
  task :curl do
    puts 'checking for curl...'
    abort('install curl and try again') unless system('which curl')
  end
end

desc 'Pull CLDR source file from the CLDR JSON source'
task pull_cldr: %w[check:curl check:jq] do
  puts 'pulling CLDR source...'
  ruby './pullers/cldr.rb'
  puts '🤟 Pulled CLDR!'
end

desc 'Pull full source file from unicode.org public site'
task pull_full: %w[check:curl] do
  puts 'pulling full source...'
  ruby './pullers/full.rb'
  puts '🤟 Pulled Full!' # this is awkward wording. TODO.
end

desc 'Pull emoji source file from unicode.org public site'
task pull_emoji: %w[check:curl] do
  puts 'pulling emoji source...'
  ruby './pullers/emoji.rb'
  puts '🤟 Pulled emoji!'
end
