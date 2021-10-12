# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bcrypt', '3.1.12'
gem 'bootstrap', '~> 4.4.1'
gem 'carrierwave'
gem 'coffee-rails', '4.2.2'
gem 'devise'
gem 'dotenv-rails'
gem 'faker'
gem 'jbuilder',     '2.7.0'
gem 'jquery-rails', '4.3.1'
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'puma', '4.3.9'
gem 'rails', '5.1.6'
gem 'rubocop', require: false
gem 'sass-rails', '5.0.6'
gem 'turbolinks', '5.0.1'
gem 'uglifier', '3.2.0'

#検索用
gem 'ransack'
#フォント用
gem 'font-awesome-sass'
# slimのジェネレーターを提供してくれるslim-rails
gem 'slim-rails'

# erb→slim記法に変換するためのgem
gem 'html2slim'
# ページネーション(will_pagenateより操作性とカスタマイズ性で優れている)
gem 'kaminari'

group :development, :test do
  gem 'byebug', '9.0.6', platform: :mri
  gem 'spring-commands-rspec'
  gem 'sqlite3', '1.3.13'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console',           '3.5.1'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'guard', '2.13.0'
  gem 'guard-minitest', '2.4.4'
  gem 'launchy'
  gem 'minitest-reporters',       '1.1.14'
  gem 'rails-controller-testing', '1.0.2'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :production do
  gem 'fog', '1.42'
  gem 'pg', '0.20.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
