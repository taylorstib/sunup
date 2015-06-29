def format_thousands number
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

def day_difference_to_words diff
  if diff > 7 && diff.remainder(7) == 1
    "#{diff / 7} weeks and #{diff.remainder(7)} day"
  elsif diff > 7
    "#{diff / 7} weeks and #{diff.remainder(7)} days"
  else
    ' '
  end
end