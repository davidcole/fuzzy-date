require 'date'

class FuzzyDate

  attr_reader :short, :full, :long, :original, :fixed, :year, :month, :day, :month_name, :circa, :era

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

  private

  def analyze( date, euro )

    date = clean_parameter date

    @original = date

    date = massage date
    @fixed = date

    @year, @month, @day = nil

    if date =~ @date_patterns[ :yyyy ]
      @year  = $1.to_i

    elsif date =~ @date_patterns[ :yyyy_mm_dd_and_yyyy_mm ]
      @year  = $1.to_i
      @month = $2.to_i unless $2.nil?
      @day   = $3.to_i unless $3.nil?

    elsif date =~ @date_patterns[ :dd_mm_yyyy ] and euro
      @day   = $1.to_i
      @month = $2.to_i
      @year  = $3.to_i

    elsif date =~ @date_patterns[ :mm_dd_yyyy ]
      @month = $1.to_i
      @day   = $2.to_i
      @year  = $3.to_i

    elsif date =~ @date_patterns[ :mm_yyyy ]
      @month = $1.to_i
      @year  = $2.to_i

    elsif date =~ @date_patterns[ :dd_mmm_yyyy_and_dd_mmm ]
      month_text  = $2.to_s.capitalize
      @month      = @month_names.key( @month_abbreviations[ month_text ] )
      @day        = $1.to_i
      @year       = $3.to_i unless $3.nil?

    elsif date =~ @date_patterns[ :mmm_dd_yyyy ]
      month_text  = $1.to_s.capitalize
      @month      = @month_names.key( @month_abbreviations[ month_text ] )
      @day        = $2.to_i
      @year       = $3.to_i unless $3.nil?

    elsif date =~ @date_patterns[ :mmm_yyyy_and_mmm ]
      month_text  = $1.to_s.capitalize
      @month      = @month_names.key( @month_abbreviations[ month_text ] )
      @year       = $2.to_i unless $2.nil?

    elsif date =~ @date_patterns[ :yyyy_mmm_dd ]
      @year       = $1.to_i unless $1.nil?
      month_text  = $2.to_s.capitalize
      @month      = @month_names.key( @month_abbreviations[ month_text ] )
      @day        = $3.to_i

    elsif date =~ @date_patterns[ :yyyy_mmm ]
      @year       = $1.to_i unless $1.nil?
      month_text  = $2.to_s.capitalize
      @month      = @month_names.key( @month_abbreviations[ month_text ] )

    else
      raise ArgumentError.new( 'Cannot parse date.' )
    end

    #- Make sure the dates make sense
    if @month and @month > 13
      raise ArgumentError.new( 'Month cannot be greater than 12.' )
    elsif @month and @day and @day > @days_in_month[ @month ]
      unless @month == 2 and @year and Date.parse( '1/1/' + @year ).leap? and @day == 29
        raise ArgumentError.new( 'Too many days in this month.' )
      end
    elsif @month and @month < 1
      raise ArgumentError.new( 'Month cannot be less than 1.' )
    elsif @day and @day < 1
      raise ArgumentError.new( 'Day cannot be less than 1.' )
    end

    @month_name = @month_names[ @month ]

    # ----------------------------------------------------------------------

    show_era    = @eras[@era] == :bce ? ' ' + @era : ''
    show_circa  = @circa ? 'About ' : ''

    if @year and @month and @day
      @short = show_circa + @month.to_s + '/' + @day.to_s + '/' + @year.to_s + show_era
      @long  = show_circa + @month_name + ' ' + @day.to_s + ', ' + @year.to_s + show_era
      modified_long = show_circa + @month_name + ' ' + @day.to_s + ', ' + @year.to_s.rjust( 4, "0" ) + show_era
      @full  = show_circa + Date.parse( modified_long ).strftime( '%A,' ) + Date.parse( @day.to_s + ' ' + @month_name + ' ' + @year.to_s.rjust( 4, "0" ) ).strftime( ' %B %-1d, %Y' ) + show_era
    elsif @year and @month
      @short = show_circa + @month.to_s + '/' + @year.to_s + show_era
      @long  = show_circa + @month_name + ', ' + @year.to_s + show_era
      @full  = @long
    elsif @month and @day
      month_text = @month_abbreviations.key( month_text ) || month_text
      @short = show_circa + @day.to_s + '-' + month_text
      @long  = show_circa + @day.to_s + ' ' + @month_name
      @full  = @long
    elsif year
      @short  = show_circa + @year.to_s + show_era
      @long   = @short
      @full   = @long
    end

  end

  def clean_parameter( date )
    date.to_s.strip if date.respond_to? :to_s
  end

  def massage( date )

    date_in_parts = []

    date_separator = Regexp.new DATE_SEPARATOR, true

    #- Split the string

    date_in_parts = date.split date_separator
    date_in_parts.delete_if { |d| d.to_s.empty? }
    if date_in_parts.first.match Regexp.new( @circa_words.join( '|' ), true )
      @circa = true
      date_in_parts.shift
    end
    if date_in_parts.last.match Regexp.new( @eras.keys.join( '|' ), true )
      @era = date_in_parts.pop.upcase.strip
    end

    date_in_parts.join '-'
  end

end
