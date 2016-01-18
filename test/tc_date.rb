#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'fuzzy-date'

class DateTest < Test::Unit::TestCase

  def setup
    future_date = Date.new( 10_000, 1, 1 )

    @test_dates = {
      '2010-04-05' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'AD',
          :fixed      => '2010-04-05',
          :full       => 'Monday, 5 April 2010',
          :long       => '5 April 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010-04-05',
          :short      => '4/5/2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '2010 04 05 BC' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'BC',
          :fixed      => '2010-04-05',
          :full       => 'Monday, 5 April 2010 BC',
          :long       => '5 April 2010 BC',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010 04 05 BC',
          :short      => '4/5/2010 BC',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( -2010, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '2010 04 05 BCE' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'BCE',
          :fixed      => '2010-04-05',
          :full       => 'Monday, 5 April 2010 BCE',
          :long       => '5 April 2010 BCE',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010 04 05 BCE',
          :short      => '4/5/2010 BCE',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( -2010, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '2010-04' => {
        :parsed_date => {
          :circa      => false,
          :day        => nil,
          :era        => 'AD',
          :fixed      => '2010-04',
          :full       => 'April 2010',
          :long       => 'April 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010-04',
          :short      => '4/2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 4, 1 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '2010' => {
        :parsed_date => {
          :circa      => false,
          :day        => nil,
          :era        => 'AD',
          :fixed      => '2010',
          :full       => '2010',
          :long       => '2010',
          :month      => nil,
          :month_name => nil,
          :original   => '2010',
          :short      => '2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 1, 1 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '2010 BC' => {
        :parsed_date => {
          :circa      => false,
          :day        => nil,
          :era        => 'BC',
          :fixed      => '2010',
          :full       => '2010 BC',
          :long       => '2010 BC',
          :month      => nil,
          :month_name => nil,
          :original   => '2010 BC',
          :short      => '2010 BC',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( -2010, 1, 1 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '4/5/2010' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'AD',
          :fixed      => '4-5-2010',
          :full       => 'Monday, 5 April 2010',
          :long       => '5 April 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/5/2010',
          :short      => '4/5/2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '4/5/10' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'AD',
          :fixed      => '4-5-10',
          :full       => 'Saturday, 5 April 0010',
          :long       => '5 April 0010',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/5/10',
          :short      => '4/5/0010',
          :year       => 10,
          :sortable   => ( future_date - Date.new( 10, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      },
      '3/5/2010' => {
        :parsed_date => {
          :circa      => false,
          :day        => 3,
          :era        => 'AD',
          :fixed      => '3-5-2010',
          :full       => 'Monday, 3 May 2010',
          :long       => '3 May 2010',
          :month      => 5,
          :month_name => 'May',
          :original   => '3/5/2010',
          :short      => '5/3/2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 5, 3 ) ).to_i
        },
        :options => {
          :euro    => true
        }
      },
      '4/2010' => {
        :parsed_date => {
          :circa      => false,
          :day        => nil,
          :era        => 'AD',
          :fixed      => '4-2010',
          :full       => 'April 2010',
          :long       => 'April 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/2010',
          :short      => '4/2010',
          :year       => 2010,
          :sortable   => ( future_date - Date.new( 2010, 4, 1 ) ).to_i
        },
        :options => {
          :euro    => true
        }
      },
      '5 April' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'AD',
          :fixed      => '5-April',
          :full       => '5 April',
          :long       => '5 April',
          :month      => 4,
          :month_name => 'April',
          :original   => '5 April',
          :short      => '5-Apr',
          :year       => nil,
          :sortable   => ( future_date - Date.new( -10_000, 4, 5 ) ).to_i
        },
        :options => {
          :euro    => false
        },
      },
      '2015 June' => {
        :parsed_date => {
          :circa      => false,
          :day        => nil,
          :era        => "AD",
          :fixed      => "2015-June",
          :full       => "June 2015",
          :long       => "June 2015",
          :month      => 6,
          :month_name => "June",
          :original   => "2015 June",
          :short      => "6/2015",
          :year       => 2015,
          :sortable   => ( future_date - Date.new( 2015, 6, 1 ) ).to_i
        },
        :options    => {
          :euro    => false
        }
      },
      '2015 June 15' => {
        :parsed_date => {
          :circa      => false,
          :day        => 15,
          :era        => "AD",
          :fixed      => "2015-June-15",
          :full       => "Monday, 15 June 2015",
          :long       => "15 June 2015",
          :month      => 6,
          :month_name => "June",
          :original   => "2015 June 15",
          :short      => "6/15/2015",
          :year       => 2015,
          :sortable   => ( future_date - Date.new( 2015, 6, 15 ) ).to_i
        },
        :options    => {
          :euro    => false
        }
      },
      '10 June 15' => {
        :parsed_date => {
          :circa      => false,
          :day        => 10,
          :era        => "AD",
          :fixed      => "10-June-15",
          :full       => "Monday, 10 June 0015",
          :long       => "10 June 0015",
          :month      => 6,
          :month_name => "June",
          :original   => "10 June 15",
          :short      => "6/10/0015",
          :year       => 15,
          :sortable   => ( future_date - Date.new( 15, 6, 10 ) ).to_i
        },
        :options    => {
          :euro    => false
        }
      },
      '29 February 1836' => {
        :parsed_date => {
          :circa      => false,
          :day        => 29,
          :era        => 'AD',
          :fixed      => '29-February-1836',
          :full       => 'Monday, 29 February 1836',
          :long       => '29 February 1836',
          :month      => 2,
          :month_name => 'February',
          :original   => '29 February 1836',
          :short      => '2/29/1836',
          :year       => 1836,
          :sortable   => ( future_date - Date.new( 1836, 2, 29 ) ).to_i
        },
        :options => {
          :euro    => false
        }
      }
    }
  end

  def test_dates
    @test_dates.each do | date, data |
      fd = FuzzyDate.parse( date, data[ :options ][ :euro ] || false )
      data[ :parsed_date ].each do | key, value |
        assert_equal( value, fd.send( key ), "#{ date }#{ ' (euro)' if data[ :options ][ :euro ] } failed at :#{ key }."  )
      end
    end
  end

  def test_hash
    @test_dates.each do | date, data |
      fd = FuzzyDate.parse( date, data[ :options ][ :euro ] || false ).to_hash
      data[ :parsed_date ].each do | key, value |
        assert_equal( value, fd[ key ], "#{ date }#{ ' (euro)' if data[ :options ][ :euro ] } failed at :#{ key }."  )
      end
    end
  end

  def test_comparable
    parsed_dates = @test_dates.keys.map { |date| FuzzyDate.parse date }

    # standard sort
    assert_equal([
        "2010 04 05 BCE",
        "2010 04 05 BC",
        "2010 BC",
        "4/5/10",
        "10 June 15",
        "29 February 1836",
        "3/5/2010",
        "4/5/2010",
        "2010-04-05",
        "4/2010",
        "2010-04",
        "2010",
        "2015 June 15",
        "2015 June",
        "5 April"
      ],
      parsed_dates.sort.map(&:original),
      "Standard sort failed."
    )

    # reverse sort
    assert_equal([
        "5 April",
        "2015 June",
        "2015 June 15",
        "2010",
        "4/2010",
        "2010-04",
        "2010-04-05",
        "4/5/2010",
        "3/5/2010",
        "29 February 1836",
        "10 June 15",
        "4/5/10",
        "2010 BC",
        "2010 04 05 BCE",
        "2010 04 05 BC"
      ],
      parsed_dates.sort { |d1, d2| d1.<=> d2, reverse: true }.map(&:original),
      "Reverse sort failed."
    )

    # floaty sort
    assert_equal([
        "2010 BC",
        "2010 04 05 BC",
        "2010 04 05 BCE",
        "5 April",
        "4/5/10",
        "10 June 15",
        "29 February 1836",
        "2010",
        "3/5/2010",
        "2010-04",
        "4/2010",
        "4/5/2010",
        "2010-04-05",
        "2015 June",
        "2015 June 15"
      ],
      parsed_dates.sort { |d1, d2| d1.<=> d2, floaty: true }.map(&:original),
      "Floaty sort failed."
    )

    # reverse floaty sort -- one day...
    # assert_equal([
    #     "5 April",
    #     "2015 June",
    #     "2015 June 15",
    #     "2010",
    #     "2010-04-05",
    #     "2010-04",
    #     "4/2010",
    #     "4/5/2010",
    #     "3/5/2010",
    #     "29 February 1836",
    #     "10 June 15",
    #     "4/5/10",
    #     "2010 BC"
    #     "2010 04 05 BCE",
    #     "2010 04 05 BC",
    #   ],
    #   parsed_dates.sort { |d1, d2| d1.<=> d2, reverse: true, floaty: true }.map(&:original),
    #   "Reverse floaty sort failed."
    # )
  end
end
