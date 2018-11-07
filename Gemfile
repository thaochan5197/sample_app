source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.3"

gem "bcrypt", "3.1.12"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "3.3.7"
gem "coffee-rails", "~> 4.2"
gem "cocoon"
gem "jbuilder", "~> 2.5"
gem "puma", "~> 3.11"
gem "rails-i18n"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "config"
gem "jquery-rails"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "rails", "~> 5.2.1"
  gem "rubocop", "~> 0.54.0", require: false
  gem "sass-rails", "~> 5.0"
  gem "sqlite3"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end
