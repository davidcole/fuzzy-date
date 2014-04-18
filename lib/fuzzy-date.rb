require 'fuzzy-date/analyze'
require 'fuzzy-date/variables'
require 'fuzzy-date/fuzzy-date'

class FuzzyDate
  VERSION = '0.1.6'

  def self.parse( date, euro = false )
    fuzzy_date = FuzzyDate.new date, euro
    fuzzy_date.to_hash
  end
end
