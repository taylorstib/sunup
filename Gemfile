source 'https://rubygems.org'
ruby "2.1.2"
gem 'sinatra', '1.4.5'
gem 'activesupport', '4.2.0'

group :production do
  gem 'puma', :group => :production 
end

group :development do 
  gem 'thin', '~> 1.6.2'
  gem 'sinatra-contrib'
  gem 'better_errors'
  gem 'binding_of_caller'
end