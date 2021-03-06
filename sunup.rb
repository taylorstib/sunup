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
    {opponent: 'bears',     date: Date.new(2015,9,13),  location: :away, result: 'W 31 - 23', win: true},
    {opponent: 'seahawks',  date: Date.new(2015,9,20),  location: :home, result: 'W 27 - 17', win: true,  prime: 'Sunday Night'},
    {opponent: 'chiefs',    date: Date.new(2015,9,28),  location: :home, result: 'W 38 - 28', win: true,  prime: 'Monday Night'},
    {opponent: '49ers',     date: Date.new(2015,10,4),  location: :away, result: 'W 17 - 3',  win: true},
    {opponent: 'rams',      date: Date.new(2015,10,11), location: :home, result: 'W 24 - 10', win: true},
    {opponent: 'chargers',  date: Date.new(2015,10,18), location: :home, result: 'W 27 - 20', win: true},
    {opponent: 'broncos',   date: Date.new(2015,11,1),  location: :away, result: 'L 10 - 29', win: false, prime: "Sunday Night"},
    {opponent: 'panthers',  date: Date.new(2015,11,8),  location: :away, result: 'L 29 - 37', win: false},
    {opponent: 'lions',     date: Date.new(2015,11,15), location: :home, result: 'L 16 - 18', win: false},
    {opponent: 'vikings',   date: Date.new(2015,11,22), location: :away, result: 'W 30 - 13', win: true },
    {opponent: 'bears',     date: Date.new(2015,11,26), location: :home, result: 'L 13 - 17', win: false, prime: "Sunday Night"},
    {opponent: 'lions',     date: Date.new(2015,12,3),  location: :away, result: 'W 27 - 23', win: true,  prime: "Thursday Night"},
    {opponent: 'cowboys',   date: Date.new(2015,12,13), location: :home, result: 'W 28 - 7',  win: true},
    {opponent: 'raiders',   date: Date.new(2015,12,20), location: :away, result: 'W 30 - 20', win: true},
    {opponent: 'cardinals', date: Date.new(2015,12,27), location: :away, result: 'L 8 - 38',  win: false},
    {opponent: 'vikings',   date: Date.new(2016,1,3),   location: :home, prime: 'Sunday Night Football'}
  ]
end

before '*/mnf' do
  @games = [
    {date: Date.new(2015,9,14),  home: 'Falcons*',   away: 'Eagles',    result: '26 - 24' },
    {date: Date.new(2015,9,14),  home: '49ers*',     away: 'Vikings',   result: '20 - 3' },
    {date: Date.new(2015,9,21),  home: 'Colts',      away: 'Jets*',     result: '7 - 20' },
    {date: Date.new(2015,9,28),  home: 'Packers*',   away: 'Chiefs',    result: '38 - 28' },
    {date: Date.new(2015,10,5),  home: 'Seahawks*',  away: 'Lions',     result: '13 - 10' },
    {date: Date.new(2015,10,12), home: 'Chargers',   away: 'Steelers*', result: '20 - 24' },
    {date: Date.new(2015,10,19), home: 'Eagles*',    away: 'Giants',    result: '27 - 7' },
    {date: Date.new(2015,10,26), home: 'Cardinals*', away: 'Ravens',    result: '26 - 18' },
    {date: Date.new(2015,11,2),  home: 'Panthers*',  away: 'Colts',     result: '29 - 26' },
    {date: Date.new(2015,11,9),  home: 'Chargers',   away: 'Bears*',    result: '19 - 22' },
    {date: Date.new(2015,11,16), home: 'Bengals',    away: 'Texans*',   result: '6 - 10' },
    {date: Date.new(2015,11,23), home: 'Patriots*',  away: 'Bills',     result: '20 - 13' },
    {date: Date.new(2015,11,30), home: 'Browns',     away: 'Ravens*',   result: '27 - 33' },
    {date: Date.new(2015,12,7),  home: 'Redskins',   away: 'Cowboys*',  result: '16 - 19' },
    {date: Date.new(2015,12,14), home: 'Dolphins',   away: 'Giants*',   result: '24 - 31' },
    {date: Date.new(2015,12,21), home: 'Saints',     away: 'Lions*',    result: '27 - 35' },
    {date: Date.new(2015,12,28), home: 'Broncos*',   away: 'Bengals',   result: '20 - 7' }
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
    {date: Date.new(2015,9,10),  home: 'Patriots*', away: 'Steelers',   result: '28 - 21' },
    {date: Date.new(2015,9,13),  home: 'Cowboys*',  away: 'Giants',     result: '27 - 26' },
    {date: Date.new(2015,9,20),  home: 'Packers*',  away: 'Seahawks',   result: '27 - 17' },
    {date: Date.new(2015,9,27),  home: 'Lions',     away: 'Broncos*',   result: '12 - 24' },
    {date: Date.new(2015,10,4),  home: 'Saints*',   away: 'Cowboys',    result: '26 - 20' },
    {date: Date.new(2015,10,11), home: 'Giants*',   away: '49ers',      result: '30 - 27' },
    {date: Date.new(2015,10,18), home: 'Colts',     away: 'Patriots*',  result: '27 - 34' },
    {date: Date.new(2015,10,25), home: 'Panthers*', away: 'Eagles',     result: '27 - 16' },
    {date: Date.new(2015,11,1),  home: 'Broncos*',  away: 'Packers',    result: '29 - 10' },
    {date: Date.new(2015,11,8),  home: 'Cowboys',   away: 'Eagles*',    result: '27 - 33' },
    {date: Date.new(2015,11,15), home: 'Seahawks',  away: 'Cardinals*', result: '39 - 32' },
    {date: Date.new(2015,11,22), home: 'Cardinals*',away: 'Bengals',    result: '34 - 31' },
    {date: Date.new(2015,11,26), home: 'Packers',   away: 'Bears*',     result: '13 - 17' },
    {date: Date.new(2015,11,29), home: 'Broncos*',  away: 'Patriots',   result: '30 - 24' },
    {date: Date.new(2015,12,6),  home: 'Steelers*', away: 'Colts',      result: '45 - 10' },
    {date: Date.new(2015,12,13), home: 'Texans',    away: 'Patriots*',  result: '6 - 27' },
    {date: Date.new(2015,12,20), home: 'Eagles',    away: 'Cardinals*', result: '17 - 40' },
    {date: Date.new(2015,12,27), home: 'Vikings*',  away: 'Giants',     result: '49 - 17' },
    {date: Date.new(2016,1,3),   home: 'Packers',   away: 'Vikings',    result: nil }
  ]
  # @teams = []
  # @games.each do |game|
  #   @teams.push(game[:home])
  #   @teams.push(game[:away])
  # end
  # puts "#{@teams.uniq.count} unique teams"
end

before '*/tnf' do
  @games = [
    {date: Date.new(2015,9,17),  home: 'Chiefs',     away: 'Broncos*',   result: '31 - 24' },
    {date: Date.new(2015,9,24),  home: 'Giants*',    away: 'Redskins',   result: '21 - 32' },
    {date: Date.new(2015,10,1),  home: 'Steelers',   away: 'Ravens*',    result: '20 - 23' },
    {date: Date.new(2015,10,8),  home: 'Texans',     away: 'Colts*',     result: '27 - 20' },
    {date: Date.new(2015,10,15), home: 'Saints*',    away: 'Falcons',    result: '31 - 21' },
    {date: Date.new(2015,10,22), home: '49ers',      away: 'Seahawks*',  result: '3 - 30' },
    {date: Date.new(2015,10,29), home: 'Patriots*',  away: 'Dolphins',   result: '36 - 10' },
    {date: Date.new(2015,11,5),  home: 'Bengals*',   away: 'Browns',     result: '31 - 10' },
    {date: Date.new(2015,11,12), home: 'Jets',       away: 'Bills*',     result: '17 - 22' },
    {date: Date.new(2015,11,19), home: 'Jaguars*',   away: 'Titans',     result: '19 - 13' },
    {date: Date.new(2015,12,3),  home: 'Lions',      away: 'Packers*',   result: '27 - 23' },
    {date: Date.new(2015,12,10), home: 'Cardinals*', away: 'Vikings',    result: '23 - 20' },
    {date: Date.new(2015,12,17), home: 'Rams*',      away: 'Buccaneers', result: '31 - 23' },
    {date: Date.new(2015,12,19), home: 'Cowboys',    away: 'Jets*',      result: '16 - 19' },
    {date: Date.new(2015,12,24), home: 'Raiders*',   away: 'Chargers',   result: '23 - 20' },
    {date: Date.new(2015,12,26), home: 'Eagles',     away: 'Redskins*',  result: '24 - 38' }
  ]
end

get '/' do
  @today
  erb :index, :locals => { :today => @today, :thing => @thing }
end

get '/all' do
  @dates = [
    {event: 'Today',                      date: Date.today},
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
    {event: 'Wisonsin',                   date: Date.new(2015,9,4)},
    {event: 'NFL First Game',             date: Date.new(2015,9,10)},
    {event: 'Packer\'s first Reg Game',   date: Date.new(2015,9,13)},
    {event: 'Work Retreat',               date: Date.new(2015,9,11)},
    {event: 'Matt\'s Bday',               date: Date.new(2015,9,25)},
    {event: 'My Bday',                    date: Date.new(2015,10,7)},
    {event: 'Kendall Bday',               date: Date.new(2015,10,13)},
    {event: 'Hassan Bday',                date: Date.new(2015,10,12)},
    {event: 'Jake\'s Wedding',            date: Date.new(2015,10,23)},
    {event: 'Halloween',                  date: Date.new(2015,10,31)},
    {event: 'Thanksgiving',               date: Date.new(2015,11,26)},
    {event: 'Becca\'s Bday',              date: Date.new(2015,11,29)},
    {event: 'Holiday Party',              date: Date.new(2015,12,11)},
    {event: 'Christmas',                  date: Date.new(2015,12,25)},
    {event: 'New Years',                  date: Date.new(2016,1,1)}
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

get '/tnf' do
  erb :tnf
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

get '/api/tnf' do
  content_type :json
  @games.to_json
end
