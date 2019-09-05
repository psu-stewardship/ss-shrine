# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'aws-sdk-s3', '~> 1.14'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'figaro'
gem 'image_processing'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'shrine', '~> 3.0.0.beta'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'niftany'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'flog'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'xray-rails'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'webdrivers'
end
