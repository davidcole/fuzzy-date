require 'fuzzy-date/analyze'
require 'fuzzy-date/variables'
require 'fuzzy-date/fuzzy-date'

class FuzzyDate
  VERSION = '0.2.0'

  def self.parse( date, euro = false )
    FuzzyDate.new date, euro
  end
end
