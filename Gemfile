source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma',  ">= 3.12.4"
gem 'active_model_serializers', '~> 0.10.10'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise_token_auth'
gem 'rack', '>= 2.2.3'
gem 'rack-cors', '~> 1.0', '>= 1.0.3'
gem 'data_migrate', '~> 6.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  gem 'faker', '~> 2.1', '>= 2.1.2'
  gem 'rubocop', '~> 0.74.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end

group :test do
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'database_cleaner', '~> 1.7'
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
