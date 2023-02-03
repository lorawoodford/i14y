require 'csv'

class String
  def extract_array
    CSV.parse_line(self).flatten.map(&:strip).map(&:downcase)
  end
end
