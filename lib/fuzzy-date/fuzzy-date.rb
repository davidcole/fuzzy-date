class FuzzyDate
  
  def initialize( date, euro = false )
    setup
    analyze date, euro
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

end