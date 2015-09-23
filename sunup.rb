# Copyright Taylor Stib 2015

require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support'
require 'active_support/core_ext/date'
require 'active_support/core_ext/numeric/conversions'
require 'date'
require 'better_errors' if development?
require 'sinatra/json'
require_relative 'helpers/application_helper'

helpers ApplicationHelper

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
  enable :logging
end

before do
  @today = (Time.now - (3600*7)).to_date
end

before '*/packers' do
  @games = [
    {opponent: 'bears', date: Date.new(2015,9,13), location: :away,    result: 'W 31 - 23', win: true},
    {opponent: 'seahawks', date: Date.new(2015,9,20), location: :home, result: 'W 27 - 17', win: true},
    {opponent: 'chiefs', date: Date.new(2015,9,28), location: :home},
    {opponent: '49ers', date: Date.new(2015,10,4), location: :away},
    {opponent: 'rams', date: Date.new(2015,10,11), location: :home},
    {opponent: 'chargers', date: Date.new(2015,10,18), location: :home},
    {opponent: 'broncos', date: Date.new(2015,11,1), location: :away},
    {opponent: 'panthers', date: Date.new(2015,11,8), location: :away},
    {opponent: 'lions', date: Date.new(2015,11,15), location: :home},
    {opponent: 'vikings', date: Date.new(2015,11,22), location: :away},
    {opponent: 'bears', date: Date.new(2015,11,26), location: :home},
    {opponent: 'lions', date: Date.new(2015,12,3), location: :away},
    {opponent: 'cowboys', date: Date.new(2015,12,13), location: :home},
    {opponent: 'raiders', date: Date.new(2015,12,20), location: :away},
    {opponent: 'cardinals', date: Date.new(2015,12,27), location: :away},
    {opponent: 'vikings', date: Date.new(2015,1,3), location: :home}
  ]
end

before '*/mnf' do
  @games = [
    {date: Date.new(2015,9,14), home: 'Falcons*', away: 'Eagles',    result: '26 - 24' },
    {date: Date.new(2015,9,14), home: '49ers*', away: 'Vikings',     result: '20 - 3' },
    {date: Date.new(2015,9,21), home: 'Colts', away: 'Jets*',        result: '7 - 20' },
    {date: Date.new(2015,9,28), home: 'Packers', away: 'Chiefs',     result: nil },
    {date: Date.new(2015,10,5), home: 'Seahawks', away: 'Lions',     result: nil },
    {date: Date.new(2015,10,12), home: 'Chargers', away: 'Steelers', result: nil },
    {date: Date.new(2015,10,19), home: 'Eagles', away: 'Giants',     result: nil },
    {date: Date.new(2015,10,26), home: 'Cardinals', away: 'Ravens',  result: nil },
    {date: Date.new(2015,11,2), home: 'Panthers', away: 'Colts',     result: nil },
    {date: Date.new(2015,11,9), home: 'Chargers', away: 'Bears',     result: nil },
    {date: Date.new(2015,11,16), home: 'Bengals', away: 'Texans',    result: nil },
    {date: Date.new(2015,11,23), home: 'Patriots', away: 'Bills',    result: nil },
    {date: Date.new(2015,11,30), home: 'Browns', away: 'Ravens',     result: nil },
    {date: Date.new(2015,12,7), home: 'Redskins', away: 'Cowboys',   result: nil },
    {date: Date.new(2015,12,14), home: 'Dolphins', away: 'Giants',   result: nil },
    {date: Date.new(2015,12,21), home: 'Saints', away: 'Lions',      result: nil },
    {date: Date.new(2015,12,28), home: 'Broncos', away: 'Bengals',   result: nil }
  ]
  # @teams = []
  # @games.each do |game|
  #   @teams.push(game[:home])
  #   @teams.push(game[:away])
  # end
  # puts "#{@teams.uniq.count} unique teams"
end

before '*/snf' do
  @games = [
    {date: Date.new(2015,9,10), home: 'Patriots*', away: 'Steelers',  result: '28 - 21' },
    {date: Date.new(2015,9,13), home: 'Cowboys*', away: 'Giants',     result: '27 - 26' },
    {date: Date.new(2015,9,20), home: 'Packers*', away: 'Seahawks',   result: '27 - 17' },
    {date: Date.new(2015,9,27), home: 'Lions', away: 'Broncos',       result: nil },
    {date: Date.new(2015,10,4), home: 'Saints', away: 'Cowboys',      result: nil },
    {date: Date.new(2015,10,11), home: 'Giants', away: '49ers',       result: nil },
    {date: Date.new(2015,10,18), home: 'Colts', away: 'Patriots',     result: nil },
    {date: Date.new(2015,10,25), home: 'Panthers', away: 'Eagles',    result: nil },
    {date: Date.new(2015,11,1), home: 'Broncos', away: 'Packers',     result: nil },
    {date: Date.new(2015,11,8), home: 'Cowboys', away: 'Eagles',      result: nil },
    {date: Date.new(2015,11,15), home: 'Seahawks', away: 'Cardinals', result: nil },
    {date: Date.new(2015,11,22), home: 'Chargers', away: 'Chiefs',    result: nil },
    {date: Date.new(2015,11,26), home: 'Packers', away: 'Bears',      result: nil },
    {date: Date.new(2015,11,29), home: 'Broncos', away: 'Patriots',   result: nil },
    {date: Date.new(2015,12,6), home: 'Steelers', away: 'Colts',      result: nil },
    {date: Date.new(2015,12,13), home: 'Ravens', away: 'Seahawks',    result: nil },
    {date: Date.new(2015,12,20), home: '49ers', away: 'Bengals',      result: nil },
    {date: Date.new(2015,12,27), home: 'Ravens', away: 'Steelers',    result: nil }
  ]
  # @teams = []
  # @games.each do |game|
  #   @teams.push(game[:home])
  #   @teams.push(game[:away])
  # end
  # puts "#{@teams.uniq.count} unique teams"
end

get '/' do
  @today
  erb :index, :locals => { :today => @today, :thing => @thing }
end

get '/all' do
  @dates = [
    {event: 'Today',                      date: Date.today},
    {event: 'Matt\'s Bday',               date: Date.new(2015,9,25)},
    {event: 'My Bday',                    date: Date.new(2015,10,7)},
    {event: 'Kendall Bday',               date: Date.new(2015,10,13)},
    {event: 'Hassan Bday',                date: Date.new(2015,10,12)},
    {event: 'Jake\'s Wedding',            date: Date.new(2015,10,23)},
    {event: 'Next Red Cross',             date: Date.new(2015,10,29)},
    {event: 'Halloween',                  date: Date.new(2015,10,31)},
    {event: 'Dublin Conference',          date: Date.new(2015,11,3)},
    {event: 'Thanksgiving',               date: Date.new(2015,11,26)},
    {event: 'Christmas',                  date: Date.new(2015,12,25)},
    {event: 'New Years',                  date: Date.new(2016,1,1)},
    {event: 'Super Bowl',                 date: Date.new(2016,2,7)},
    {event: 'Matt\'s Match Day',          date: Date.new(2016,3,18)},
    {event: 'M&B Wedding',                date: Date.new(2016,4,16)},
    {event: 'Randy Wedding',              date: Date.new(2016,6,18)},
    {event: 'Summer Olympics Brazil',     date: Date.new(2016,8,5)}
    # {event: 'NEW EVENT', date: Date.new()},
    ]
  @past_dates = [
    {event: 'Started Work',               date: Date.new(2015,3,5)},
    {event: 'Got Pip',                    date: Date.new(2015,6,10)},
    {event: 'Engagement',                 date: Date.new(2015,7,11)},
    {event: 'Cabo',                       date: Date.new(2015,7,21)},
    {event: 'Parents Cabo',               date: Date.new(2015,8,15)},
    {event: 'UofA First Game',            date: Date.new(2015,9,3)},
    {event: 'Red Cross',                  date: Date.new(2015,9,3)},
    {event: 'Wisonsin',                   date: Date.new(2015,9,4)},
    {event: 'NFL First Game',             date: Date.new(2015,9,10)},
    {event: 'Packer\'s first Reg Game',   date: Date.new(2015,9,13)},
    {event: 'Work Retreat',               date: Date.new(2015,9,11)}
  ]

  erb :all_in_one, :locals => {:dates => @dates }
end

get '/packers' do
  erb :packers
end

get '/mnf' do
  erb :mnf
end

get '/snf' do
  erb :snf
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
  @today
  if !params[:date].blank?
    @date = Date.strptime(params[:date], "%m/%d/%Y")
  elsif !params[:month].blank?
    @month = params[:month].to_i
    @day = params[:day].to_i
    @year = params[:year].to_i
    @date = Date.new(@year,@month,@day)
  end
  # Do not want a negative result
  if @today > @date
    @diff = (@today - @date).to_i
    fridays = (@date..@today).select { |k| k.wday == 5 }
    @fridays = fridays.count
  else
    @diff = (@date - @today).to_i
    fridays = (@today..@date).select { |k| k.wday == 5 }
    @fridays = fridays.count
  end

  if @diff
    @words = day_difference_to_words @diff
    @amount = format_thousands(@fridays*717)
    @savings = format_thousands(@fridays*135)
    @left_over = format_thousands(@fridays*400)
  else
    @words = ''
    @amount = ''
    @savings = ''
  end
  erb :diff, :locals => { date: @date, diff: @diff, words: @words, amount: @amount, savings: @savings, left_over: @left_over, fridays: @fridays }
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
    fridays = (@date..@today).select { |k| k.wday == 5 }
    @fridays = fridays.count
  else
    @diff = (@date - @today).to_i
    fridays = (@today..@date).select { |k| k.wday == 5 }
    @fridays = fridays.count
  end


  if @diff
    @words = day_difference_to_words @diff
    @amount = format_thousands(@fridays*717)
    @savings = format_thousands(@fridays*135)
    @left_over = format_thousands(@fridays*400)
  else
    @words = ''
    @amount = ''
  end

  erb :diff, :locals => { date: @date, diff: @diff, words: @words, amount: @amount, savings: @savings, left_over: @left_over, fridays: @fridays }
end


###########################################
###########     API     ###################
###########################################

get '/today' do
  json today: @today
end

get '/api/days/:num_days' do
  @today
  @num_days = params[:num_days].to_i
  @date = @today - @num_days

  json date: @date.strftime('%B %d, %Y')
end


get '/api/date/:month/:day/:year' do
  @today
    if !params[:date].blank?
      @date = Date.strptime(params[:date], "%m/%d/%Y")
    elsif !params[:month].blank?
      @month = params[:month].to_i
      @day = params[:day].to_i
      @year = params[:year].to_i
      @date = Date.new(@year,@month,@day)
    end
    # Do not want a negative result
    if @today > @date
      @diff = (@today - @date).to_i
    else
      @diff = (@date - @today).to_i
    end
  json date: "#{@date}", difference: "#{format_thousands(@diff)}"
end

get '/api/packers' do
  content_type :json
  @games.to_json
end

get '/api/mnf' do
  content_type :json
  @games.to_json
end

get '/api/snf' do
  content_type :json
  @games.to_json
end