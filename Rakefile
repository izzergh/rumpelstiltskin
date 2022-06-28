# frozen_string_literal: true

desc 'Pull and update all source files'
task :pull_all do
  Rake::Task['pull_base'].invoke
  Rake::Task['pull_emoji'].invoke
end

namespace :check do
  desc 'check for curl binary'
  task :curl do
    puts 'checking for curl...'
    abort('install curl and try again') unless system('which curl')
  end
end

desc 'Pull base source file from unicode.org public site'
task pull_base: %w[check:curl] do
  puts 'pulling base source...'
  ruby './pullers/base.rb'
  puts '🤟 Pulled Base!'
end

desc 'Pull emoji source file from unicode.org public site'
task pull_emoji: %w[check:curl] do
  puts 'pulling emoji source...'
  ruby './pullers/emoji.rb'
  puts '🤟 Pulled emoji!'
end
