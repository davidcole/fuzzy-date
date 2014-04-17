
require 'fuzzy-date/variables'
require 'fuzzy-date/fuzzy-date'

class FuzzyDate
  VERSION = '0.1.5'

  # *Note*: This is only for single dates - not ranges.
  #
  # Possible incoming date formats:
  # * YYYY-MM-DD  -  starts with 3 or 4 digit year, and month and day may be 1 or 2 digits
  # * YYYY-MM  -  3 or 4 digit year, then 1 or 2 digit month
  # * YYYY  -  3 or 4 digit year
  # * MM-DD-YYYY  -  1 or 2 digit month, then 1 or 2 digit day, then 1 to 4 digit year
  # * DD-MM-YYYY  -  1 or 2 digit day, then 1 or 2 digit month, then 1 to 4 digit year if euro is true
  # * MM-YYYY  -  1 or 2 digit month, then 1 to 4 digit year
  # * DD-MMM  -  1 or 2 digit day, then month name or abbreviation
  # * DD-MMM-YYYY  -  1 or 2 digit day, then month name or abbreviation, then 1 to 4 digit year
  # * MMM-YYYY   -  month name or abbreviation, then 1 to 4 digit year
  # * MMM-DD-YYYY  -  month name or abbreviation, then 1 or 2 digit day, then 1 to 4 digit year
  #
  # Notes:
  # - Commas are optional.
  # - Delimiters can be most anything non-alphanumeric.
  # - All dates may be suffixed with the era (AD, BC, CE, BCE). AD is assumed.
  # - Dates may be prefixed by circa words (Circa, About, Abt).

  def self.parse( date, euro = false )
    fuzzy_date = FuzzyDate.new date, euro
    fuzzy_date.to_hash
  end
end
