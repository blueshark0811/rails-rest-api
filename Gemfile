source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.20'
gem 'puma', '~> 5.6'
gem 'sass-rails', '~> 5.0'
gem 'haml'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'jwt'
gem 'devise'
gem 'pundit'

# admin part
gem 'trestle'
gem 'trestle-search', github: 'sergeyustinov/trestle-search' #path: '../trestle-search'
gem 'trestle-tinymce'
gem 'dropzonejs-rails'
###

gem 'awesome_print'
gem "rack-cors", require: "rack/cors"
gem "rest-client"
gem "whenever"
gem "daemons"

gem 'active_model_serializers'#, path: './lib/active_model_serializers'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-base64'
 gem 'mini_magick'
gem 'rmagick'
gem 'mime-types'
gem 'carrierwave-video'
gem 'carrierwave-video-thumbnailer'
gem 'carrierwave-ffmpeg'
gem "fog-aws"
gem 'rmagick'
gem 'aws-sdk', '~> 2'
gem 'carrierwave_direct'

gem 'resque'
gem 'resque-scheduler'

gem 'searchkick'

gem 'rswag'
gem 'rspec-rails', '~> 3.7' #need for rswag in prod 

gem 'pghero'
gem 'pg_query', '>= 0.9.0'

gem 'sproutvideo-rb'
gem  'yt'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '~> 2.13'
  # gem 'selenium-webdriver'

  gem 'faker'
  gem 'pry','=0.10'
  gem 'pry-nav', '~> 0.2.4'
end

group :development do
  gem 'foreman', require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
