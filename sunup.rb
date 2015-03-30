# Copyright Taylor Stib 2015

require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/core_ext/date'
require 'date'

before do
  @today = Date.today
end

get '/' do
  @today
  erb :index, :locals => { :today => @today, :thing => @thing }
end

get '/days' do 
  @today
  erb :num_days, :locals => { :today => @today }
end

post '/days' do 
  @today
  @num_days = params[:daysago].to_i
  # Allow user to go forward in time
  if @num_days > 0
    @date = @today - @num_days
  else
    @date = @today + @num_days.abs
  end
  erb :num_days, :locals => { :today => @today, :daysago => @daysago, :date => @date }
end

get '/days/:num_days' do 
  @today
  @num_days = params[:num_days].to_i
  @date = @today - @num_days

  erb :num_days, :locals => { :today => @today, :num_days => @num_days, :date => @date }
end

get '/date' do
  @today
  erb :diff,  :locals => { :today => @today }
end

post '/date' do
  puts params[:date]
  @today
  @date = Date.strptime(params[:date], "%m/%d/%Y")
  @month = @date.month
  @day = @date.day
  @year = @date.year
  # @date = Date.new(@year,@month,@day)
  # Do not want a negative result
  if @today > @date
    @diff = (@today - @date).to_i
  else
    @diff = (@date - @today).to_i
  end
  erb :diff, :locals => { :date => @date, :diff => @diff }
end

get '/date/:month/:day/:year' do
  @today
  # Turn string param into integer so it can be fed into Date.new
  @day   = params[:day].to_i
  @month = params[:month].to_i
  @year  = params[:year].to_i
  @date = Date.new(@year,@month,@day)

  # Do not want a negative result
  if @today > @date
    @diff = (@today - @date).to_i
  else
    @diff = (@date - @today).to_i
  end

  erb :diff, :locals => { :date => @date, :diff => @diff }
end

# post '/date' do
#   @today
#   @month = params[:month].to_i
#   @day   = params[:day].to_i
#   @year  = params[:year].to_i
#   @date = Date.new(@year,@month,@day)

#   # Do not want a negative result
#   if @today > @date
#     @diff = (@today - @date).to_i
#   else
#     @diff = (@date - @today).to_i
#   end

#   erb :diff, :locals => { :date => @date, :diff => @diff }
# end

