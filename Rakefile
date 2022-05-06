# frozen_string_literal: true

desc 'Pull and update all source files'
task :pull_all do
  Rake::Task['pull_cldr'].invoke
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
