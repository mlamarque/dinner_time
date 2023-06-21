# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Rails basic stack
gem "rails", "~> 7.0.4"
gem "pg"
gem "puma", "~> 6.2"
gem "dotenv-rails", require: "dotenv/rails-now"

# Search
gem "pg_search"

# Assets
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sassc-rails"
gem "bulma-rails", "~> 0.9.4"

# Views
gem "slim-rails"
gem "pagy", "~> 6.0"

# System & help
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "awesome_print"

# Security
gem "rack-attack"
gem "bcrypt", "~> 3.1.7"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers", "~> 5.3"
  gem "simplecov"
  gem "timecop"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Lint it up
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "slimcop"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "bullet"
  gem "listen", ">= 3.0.5", "< 3.2"
end

group :test do
  gem "webmock"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

gem "dockerfile-rails", ">= 1.4", group: :development
