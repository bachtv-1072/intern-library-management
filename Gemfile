source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"
gem "config"
gem "dotenv-rails"
gem "bootstrap4-kaminari-views"
gem "mysql2"
gem "rails-i18n"
gem "cocoon"
gem "bcrypt", "~> 3.1.7"
gem "kaminari"
gem "carrierwave"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "slim-rails"
gem "rails", "~> 6.0.3", ">= 6.0.3.4"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "paranoia", "~> 2.2"
gem "figaro"
gem "ransack"
gem "devise"
gem "omniauth", "1.9.1"
gem "omniauth-google-oauth2"
gem "omniauth-facebook"

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "factory_bot_rails"
  gem "rails-controller-testing"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "simplecov-rcov"
  gem "simplecov"
  gem "faker"
  gem "database_cleaner"
  gem "shoulda-matchers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
