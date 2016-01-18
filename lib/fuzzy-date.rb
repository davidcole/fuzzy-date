require 'date'

class FuzzyDate
  include Comparable

  VERSION = '1.0.0'

  attr_reader :short, :full, :long, :original, :fixed, :year, :month, :day, :month_name, :circa, :era, :sortable

  def self.parse( date, euro = false )
    new date, euro
  end

  def to_hash
    {
      circa:      @circa,
      day:        @day,
      era:        @era,
      fixed:      @fixed,
      full:       @full,
      long:       @long,
      month:      @month,
      month_name: @month_name,
      original:   @original,
      short:      @short,
      year:       @year
    }
  end

  def format( pattern )
    year  = @year  || 0
    month = @month || 1
    day   = @day   || 1

    "#{ show_circa } #{ Date.new( year, month, day ).strftime( pattern ) } #{ show_era }".strip
  end

  def <=>( o, options = {} )
    # When :float is true, date vagueness is prioritized.
    h = Hash.new (options[:floaty]) ? 0 : Float::INFINITY

    # When :reverse is true, dates are sorted in reverse chronology.
    unless options[:reverse]
      first_date, second_date = "d1", "d2"
    else
      first_date, second_date = "d2", "d1"
    end

    h["#{first_date}_era"] = (@era == "BC" || @era == "BCE") ? -1 : 1
    h["#{first_date}_year"]  = @year if @year
    h["#{first_date}_month"] = @month if @month
    h["#{first_date}_day"]   = @day if @day

    h["#{second_date}_era"] = (o.era == "BC" || o.era == "BCE") ? -1 : 1
    h["#{second_date}_year"]  = o.year if o.year
    h["#{second_date}_month"] = o.month if o.month
    h["#{second_date}_day"]   = o.day if o.day

    result = h['d1_era']  <=> h['d2_era']
    result = h['d1_year']  <=> h['d2_year']  if result == 0
    result = h['d1_month'] <=> h['d2_month'] if result == 0
    result = h['d1_day']   <=> h['d2_day']   if result == 0

    result
  end

  private

  def initialize( date, euro = false )
    @original = nil
    @circa    = false
    @year     = nil
    @month    = nil
    @day      = nil
    @era      = 'AD'

    analyze date, euro
  end

  # *Note*: This is only for single dates - not ranges.
  #
  # Possible incoming date formats:
  # * YYYY-MM-DD  -  starts with 3 or 4 digit year, and month and day may be 1 or 2 digits
  # * YYYY-MM     -  3 or 4 digit year, then 1 or 2 digit month
  # * YYYY        -  3 or 4 digit year
  # * MM-DD-YYYY  -  1 or 2 digit month, then 1 or 2 digit day, then 1 to 4 digit year
  # * DD-MM-YYYY  -  1 or 2 digit day, then 1 or 2 digit month, then 1 to 4 digit year if euro is true
  # * MM-YYYY     -  1 or 2 digit month, then 1 to 4 digit year
  # * DD-MMM      -  1 or 2 digit day, then month name or abbreviation
  # * DD-MMM-YYYY -  1 or 2 digit day, then month name or abbreviation, then 1 to 4 digit year
  # * MMM-YYYY    -  month name or abbreviation, then 1 to 4 digit year
  # * MMM-DD-YYYY -  month name or abbreviation, then 1 or 2 digit day, then 1 to 4 digit year
  # * YYYY-MMM    -  1 to 4 digit year, then month name or abbreviation
  #
  # Notes:
  # - Commas are optional.
  # - Delimiters can be most anything non-alphanumeric.
  # - All dates may be suffixed with the era (AD, BC, CE, BCE). AD is assumed.
  # - Dates may be prefixed by circa words (Circa, About, Abt).

  def analyze( date, euro )
    date = clean_parameter date

    @original = date

    date = massage date
    @fixed = date

    @year, @month, @day = nil

    if date =~ Variables::DATE_PATTERNS[ :yyyy ]
      @year  = $1.to_i

    elsif date =~ Variables::DATE_PATTERNS[ :yyyy_mm_dd_and_yyyy_mm ]
      @year  = $1.to_i
      @month = $2.to_i unless $2.nil?
      @day   = $3.to_i unless $3.nil?

    elsif date =~ Variables::DATE_PATTERNS[ :dd_mm_yyyy ] && euro
      @day   = $1.to_i
      @month = $2.to_i
      @year  = $3.to_i

    elsif date =~ Variables::DATE_PATTERNS[ :mm_dd_yyyy ]
      @month = $1.to_i
      @day   = $2.to_i
      @year  = $3.to_i

    elsif date =~ Variables::DATE_PATTERNS[ :mm_yyyy ]
      @month = $1.to_i
      @year  = $2.to_i

    elsif date =~ Variables::DATE_PATTERNS[ :dd_mmm_yyyy_and_dd_mmm ]
      month_text  = $2.to_s.capitalize
      @month      = Variables::MONTH_NAMES.key( Variables::MONTH_ABBREVIATIONS[ month_text ] )
      @day        = $1.to_i
      @year       = $3.to_i unless $3.nil?

    elsif date =~ Variables::DATE_PATTERNS[ :mmm_dd_yyyy ]
      month_text  = $1.to_s.capitalize
      @month      = Variables::MONTH_NAMES.key( Variables::MONTH_ABBREVIATIONS[ month_text ] )
      @day        = $2.to_i
      @year       = $3.to_i unless $3.nil?

    elsif date =~ Variables::DATE_PATTERNS[ :mmm_yyyy_and_mmm ]
      month_text  = $1.to_s.capitalize
      @month      = Variables::MONTH_NAMES.key( Variables::MONTH_ABBREVIATIONS[ month_text ] )
      @year       = $2.to_i unless $2.nil?

    elsif date =~ Variables::DATE_PATTERNS[ :yyyy_mmm_dd ]
      @year       = $1.to_i unless $1.nil?
      month_text  = $2.to_s.capitalize
      @month      = Variables::MONTH_NAMES.key( Variables::MONTH_ABBREVIATIONS[ month_text ] )
      @day        = $3.to_i

    elsif date =~ Variables::DATE_PATTERNS[ :yyyy_mmm ]
      @year       = $1.to_i unless $1.nil?
      month_text  = $2.to_s.capitalize
      @month      = Variables::MONTH_NAMES.key( Variables::MONTH_ABBREVIATIONS[ month_text ] )

    else
      raise ArgumentError.new( 'Cannot parse date.' )
    end

    #- Make sure the dates make sense
    if @month && @month > 13
      raise ArgumentError.new( 'Month cannot be greater than 12.' )
    elsif @month && @day && @day > Variables::DAYS_IN_MONTH[ @month ]
      unless @month == 2 && @year && Date.parse( '1/1/' + @year ).leap? && @day == 29
        raise ArgumentError.new( 'Too many days in this month.' )
      end
    elsif @month && @month < 1
      raise ArgumentError.new( 'Month cannot be less than 1.' )
    elsif @day && @day < 1
      raise ArgumentError.new( 'Day cannot be less than 1.' )
    end

    @month_name = Variables::MONTH_NAMES[ @month ]

    # ----------------------------------------------------------------------

    future_date = Date.new 10_000, 1, 1

    year = @year.to_s.rjust( 4, "0" )

    if @year && @month && @day
      @short    = "#{ show_circa } #{ @month }/#{ @day }/#{ year } #{ show_era }".strip
      @long     = "#{ show_circa } #{ @day } #{ @month_name } #{ year } #{ show_era }".strip
      @full     = "#{ show_circa } #{ Date.new( @year, @month, @day ).strftime( '%A, %-1d %B %Y' ) } #{ show_era }".strip
    elsif @year && @month
      @short    = "#{ show_circa } #{ @month }/#{ year } #{ show_era }".strip
      @long     = "#{ show_circa } #{ @month_name } #{ year } #{ show_era }".strip
      @full     = @long
    elsif @month && @day
      @short    = "#{ show_circa } #{ @day }-#{ Variables::MONTH_ABBREVIATIONS.key( month_text ) || month_text }".strip
      @long     = "#{ show_circa } #{ @day } #{ month_name }".strip
      @full     = @long
    elsif year
      @short    = "#{ show_circa } #{ year } #{ show_era }".strip
      @long     = @short
      @full     = @long
    end

  end

  def clean_parameter( date )
    date.to_s.strip if date.respond_to? :to_s
  end

  def massage( date )
    date_in_parts  = []
    date_separator = Regexp.new Variables::DATE_SEPARATOR, true

    #- Split the string

    date_in_parts = date.split date_separator
    date_in_parts.delete_if { |d| d.to_s.empty? }
    if date_in_parts.first.match Regexp.new( Variables::CIRCA_WORDS.join( '|' ), true )
      @circa = true
      date_in_parts.shift
    end
    if date_in_parts.last.match Regexp.new( Variables::ERAS.keys.join( '|' ), true )
      @era = date_in_parts.pop.upcase.strip
    end

    date_in_parts.join '-'
  end

  def show_era
    bce? ? @era : ''
  end

  def bce?
    Variables::ERAS[@era] == :bce
  end

  def show_circa
    @circa ? 'About' : ''
  end

  module Variables
    DATE_SEPARATOR  = '[^A-Za-z0-9]'

    MONTH_NAMES = { 1  => 'January',
                    2  => 'February',
                    3  => 'March',
                    4  => 'April',
                    5  => 'May',
                    6  => 'June',
                    7  => 'July',
                    8  => 'August',
                    9  => 'September',
                    10 => 'October',
                    11 => 'November',
                    12 => 'December' }

    MONTH_ABBREVIATIONS = { 'Jan' => 'January',
                            'Feb' => 'February',
                            'Mar' => 'March',
                            'Apr' => 'April',
                            'May' => 'May',
                            'Jun' => 'June',
                            'Jul' => 'July',
                            'Aug' => 'August',
                            'Sep' => 'September',
                            'Oct' => 'October',
                            'Nov' => 'November',
                            'Dec' => 'December' }

    DAYS_IN_MONTH = { 1  => 31,
                      2  => 29,
                      3  => 31,
                      4  => 30,
                      5  => 31,
                      6  => 30,
                      7  => 31,
                      8  => 31,
                      9  => 30,
                      10 => 31,
                      11 => 30,
                      12 => 31 }

    RANGE_WORDS = [ 'Between',
                    'Bet',
                    'Bet.',
                    'From' ]

    MIDDLE_RANGE_WORDS = [ 'To', 'And' ] # '-' is not used because it is more commonly used as a delimiter

    CIRCA_WORDS = [ 'Circa',
                    'About',
                    'Abt',
                    'Abt.',
                    '~' ]

    ERAS = { 'AD'  => :ce,
             'BC'  => :bce,
             'CE'  => :ce,
             'BCE' => :bce }

    DATE_PATTERNS = { yyyy:                   /^(\d{1,4})$/,
                      yyyy_mmm:               /^(\d{1,4})-(#{ MONTH_ABBREVIATIONS.keys.join( '|' ) }).*?$/i,
                      yyyy_mmm_dd:            /^(\d{1,4})-(#{ MONTH_ABBREVIATIONS.keys.join( '|' ) }).*?-(\d{1,2})$/i,
                      yyyy_mm_dd_and_yyyy_mm: /^(\d{3,4})(?:-(\d{1,2})(?:-(\d{1,2}))?)?$/,
                      dd_mm_yyyy:             /^(\d{1,2})-(\d{1,2})-(\d{1,4})$/,
                      mm_dd_yyyy:             /^(\d{1,2})-(\d{1,2})-(\d{1,4})$/,
                      mm_yyyy:                /^(\d{1,2})-(\d{1,4})?$/,
                      dd_mmm_yyyy_and_dd_mmm: /^(\d{1,2})(?:-(#{ MONTH_ABBREVIATIONS.keys.join( '|' ) }).*?(?:-(\d{1,4}))?)?$/i,
                      mmm_dd_yyyy:            /^(#{ MONTH_ABBREVIATIONS.keys.join( '|' ) }).*?-(\d{1,2})-(\d{1,4})$/i,
                      mmm_yyyy_and_mmm:       /^(#{ MONTH_ABBREVIATIONS.keys.join( '|' ) }).*?(?:-(\d{1,4}))?$/i }
  end
end
