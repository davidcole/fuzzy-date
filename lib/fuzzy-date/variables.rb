class FuzzyDate
  DATE_SEPARATOR = '[^A-Za-z0-9]'

  private

  def setup

    @date_parts = set_up_date_parts

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

    @era_words = [
      'AD',
      'BC',
      'CE',
      'BCE'
      ]
  end

  def set_up_date_parts
    @date_parts = {}
    @date_parts[ :original ] = nil
    @date_parts[ :circa    ] = false
    @date_parts[ :year     ] = nil
    @date_parts[ :month    ] = nil
    @date_parts[ :day      ] = nil
    @date_parts[ :era      ] = 'AD'
    @date_parts
  end
end