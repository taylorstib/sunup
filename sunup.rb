require 'sinatra'
require 'sinatra/reloader'
require 'active_support/core_ext/date'
require './lib/date_calc'

get '/' do
  x = DateCalc.new
  @thing = x.inspect
  @today = x.today
  erb :index, :locals => { :today => @today, :thing => @thing }
end

get '/days' do 
  erb :num_days
end

get '/days/:num_days' do 
  x = DateCalc.new
  @today = x.today
  @num_days = params[:num_days].to_i
  @date = @today - @num_days

  erb :num_days, :locals => { :today => @today, :num_days => @num_days, :date => @date }
end

get '/date' do 
  erb :diff
end

get '/date/:month/:day/:year' do
  x = DateCalc.new
  @today = x.today
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

post '/date' do
  x = DateCalc.new
  @today = x.today
  @month = params[:month].to_i
  @day   = params[:day].to_i
  @year  = params[:year].to_i
  @date = Date.new(@year,@month,@day)


  if @today > @date
    @diff = (@today - @date).to_i
  else
    @diff = (@date - @today).to_i
  end

  erb :diff, :locals => { :date => @date, :diff => @diff }
end