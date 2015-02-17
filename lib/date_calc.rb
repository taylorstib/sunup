require 'active_support/core_ext'
class DateCalc
  attr_accessor :today
  def initialize
    @today = Date.today
  end
end