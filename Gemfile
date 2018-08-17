
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
gem 'puma_worker_killer'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
gem 'capistrano', '~> 3.8.0'
gem 'capistrano-rails'
gem 'capistrano-passenger'
gem 'capistrano-rbenv'
gem 'capistrano3-puma'
gem 'capistrano-nvm'
gem 'capistrano-yarn'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use devise for authentication
gem 'devise'
gem 'devise-guests', '~> 0.5'

# CAS Authentication gems
gem 'rubycas-client', git: 'https://github.com/osulp/rubycas-client'
gem 'rubycas-client-rails', git: 'https://github.com/osulp/rubycas-client-rails'
gem 'devise_cas_authenticatable'

gem 'city-state'
gem 'jquery-rails'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?

gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'

# use font-awesome as a replacement for lost glyphicons in bootstrap 4
gem 'font-awesome-rails'
gem 'rails_admin', '~> 1.3.0'
# Use simple form for reimbursement request form
gem 'simple_form'
# Use cocoon for add/remove functionality in nested forms
gem 'cocoon'
# Use Paperclip for adding attachments
gem "paperclip", "~> 5.2.0"
# Use nested_form to help with reimbursement request form
gem 'nested_form'
# Use webpacker to support ES6 javascript
gem "webpacker", github: "rails/webpacker"

gem 'dropzonejs-rails'

# Use Wicked PDF for rendering PDF views
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# use CombinePDF for pdf export with attachments
gem 'combine_pdf'

gem 'loofah', '~> 2.2.1'
gem 'rails-html-sanitizer', '~> 1.0.4'

group :production, :staging do
  gem 'ddtrace'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'ruby-debug-ide'
  gem 'debase'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rcodetools'
  gem 'fastri'
  gem 'reek'
  gem 'debride'
  gem 'fasterer'
  gem 'rubocop'
end

group :test do
  gem 'coveralls'
  gem 'rspec_junit_formatter'
  gem 'rspec'
  gem 'rspec-mocks'
  gem 'simplecov'
  gem 'webmock'
  gem 'poltergeist'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'equivalent-xml'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
