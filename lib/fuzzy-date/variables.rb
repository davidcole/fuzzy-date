class FuzzyDate
  DATE_SEPARATOR = '[^A-Za-z0-9]'

  private

  def setup

    set_up_date_parts

    @month_names = {
      1 => 'January',
      2 => 'February',
      3 => 'March',
      4 => 'April',
      5 => 'May',
      6 => 'June',
      7 => 'July',
      8 => 'August',
      9 => 'September',
      10 => 'October',
      11 => 'November',
      12 => 'December'
      }

    @month_abbreviations = {
      'Jan' => 'January',
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
      'Dec' => 'December'
      }

    @days_in_month = {
      1 => 31,
      2 => 28,
      3 => 31,
      4 => 30,
      5 => 31,
      6 => 30,
      7 => 31,
      8 => 31,
      9 => 30,
      10 => 31,
      11 => 30,
      12 => 31
      }

    @range_words = [
      'Between',
      'Bet',
      'Bet.',
      'From'
      ]

    @middle_range_words = [
      # '-',  -  Not used because it is more commonly used as a delimiter
      'To',
      'And'
      ]

    @circa_words = [
      'Circa',
      'About',
      'Abt',
      'Abt.',
      '~'
      ]

    @era_mapping = {
      'AD' => :ce,
      'BC' => :bce,
      'CE' => :ce,
      'BCE' => :bce
      }

    @date_patterns = {
      yyyy:                   /^(\d{1,4})$/,
      yyyy_mmm:               /^(\d{1,4})-(#{ @month_abbreviations.keys.join( '|' ) }).*?$/i,
      yyyy_mmm_dd:            /^(\d{1,4})-(#{ @month_abbreviations.keys.join( '|' ) }).*?-(\d{1,2})$/i,
      yyyy_mm_dd_and_yyyy_mm: /^(\d{3,4})(?:-(\d{1,2})(?:-(\d{1,2}))?)?$/,
      dd_mm_yyyy:             /^(\d{1,2})-(\d{1,2})-(\d{1,4})$/,
      mm_dd_yyyy:             /^(\d{1,2})-(\d{1,2})-(\d{1,4})$/,
      mm_yyyy:                /^(\d{1,2})-(\d{1,4})?$/,
      dd_mmm_yyyy_and_dd_mmm: /^(\d{1,2})(?:-(#{ @month_abbreviations.keys.join( '|' ) }).*?(?:-(\d{1,4}))?)?$/i,
      mmm_dd_yyyy:            /^(#{ @month_abbreviations.keys.join( '|' ) }).*?-(\d{1,2})-(\d{1,4})$/i,
      mmm_yyyy_and_mmm:       /^(#{ @month_abbreviations.keys.join( '|' ) }).*?(?:-(\d{1,4}))?$/i
      }

  end

  def set_up_date_parts
    @original = nil
    @circa    = false
    @year     = nil
    @month    = nil
    @day      = nil
    @era      = 'AD'
  end
end
