class FuzzyDate
  
  def initialize( date, euro = false )
    setup
    analyze date, euro
  end

  def to_hash
    @date_parts
  end

end