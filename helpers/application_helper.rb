module ApplicationHelper

  def format_thousands number
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def day_difference_to_words diff
    if diff > 365
      "#{diff / 365} years, #{day_difference_to_words(diff.remainder(365))}"
    elsif diff > 7 && diff.remainder(7) == 1
      "#{diff / 7} weeks, #{diff.remainder(7)} day"
    elsif diff > 7
      "#{diff / 7} weeks, #{diff.remainder(7)} days"
    elsif diff == 7
      '7 days'
    elsif diff == 1
      "1 Day"
    else
      "#{diff.remainder(7)} days"
    end
  end

  def count_fridays today, date
    if today > date
      diff = (today - date).to_i
      fridays = (date..today).select { |k| k.wday == 5 }
      fridays = fridays.count
    else
      diff = (date - today).to_i
      fridays = (today..date).select { |k| k.wday == 5 }
      fridays = fridays.count
    end
  end
  
  def row_color(location)
    if location == :home
      'bg-yellow'
    else
      'bg-blue-grey'
    end
  end
  
  def packers_row(home, away)
    if home == "Packers" || away == "Packers"
      "bg-yellow"
    else
      ''
    end
  end

end
