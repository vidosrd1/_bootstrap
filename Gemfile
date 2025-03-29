source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.1"
gem 'rails', '~> 8.0.2'
gem "sprockets-rails"
gem 'sqlite3', '~> 2.6'
gem 'puma', '~> 6.6'
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
# gem "redis", "~> 4.0"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "sassc-rails"
gem 'image_processing', '~> 1.14'
gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'faker', '~> 3.5', '>= 3.5.1'
gem 'pagy', '~> 8.6', '>= 8.6.3'
gem 'tailwindcss-rails', '~> 4.2', '>= 4.2.1'
gem 'acts-as-taggable-on', '~> 12.0'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end
group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  # gem "spring"
end
group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'webdrivers', '~> 5.3', '>= 5.3.1'
  #gem "webdrivers"
end
