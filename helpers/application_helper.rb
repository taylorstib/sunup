def format_thousands number
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end