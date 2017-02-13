source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                    '5.0.1'
gem 'bcrypt',                   '3.1.11'
gem 'puma',                     '3.4.0'
gem 'sass-rails',               '5.0.6'
gem 'bootstrap-sass',           '3.3.6'
gem 'uglifier',                 '3.0.0'
gem 'coffee-rails',             '4.2.1'
gem 'jquery-rails',             '4.1.1'
gem 'turbolinks',               '5.0.1'
gem 'jbuilder',                 '2.4.1'
gem 'mongoid',                  '6.0.3'
gem 'faker',                    '1.6.6'
gem 'will_paginate_mongoid',    '2.0.1'
gem 'bootstrap-will_paginate',  '0.0.10'
gem 'carrierwave-mongoid',      '0.10.0'
gem 'mini_magick',              '4.5.1'
gem 'fog',                      '1.38.0'

group :development, :test do
  gem 'byebug',  '9.0.0', platform: :mri
end

group :development do
  gem 'web-console',           '3.1.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

group :test, :development do
  gem 'rspec-rails',              '3.5.2'
  gem 'capybara',                 '2.12.0'
  gem 'rails-controller-testing', '1.0.1'
  gem 'factory_girl_rails',       '4.8.0'
  gem 'database_cleaner',         '1.5.3'
  gem 'cucumber-rails',           '1.4.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]