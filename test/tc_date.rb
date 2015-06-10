#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'fuzzy-date'

class DateTest < Test::Unit::TestCase

  def setup
    @test_dates = {
      '2010-04-05' => {
        :parsed_date => {
          :circa      => false,
          :day        => 5,
          :era        => 'AD',
          :fixed      => '2010-04-05',
          :full       => 'Monday, April 5, 2010',
          :long       => 'April 5, 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010-04-05',
          :short      => '4/5/2010',
          :year       => 2010
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
          :full       => 'Tuesday, April 5, 2010 BC',
          :long       => 'April 5, 2010 BC',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010 04 05 BC',
          :short      => '4/5/2010 BC',
          :year       => 2010
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
          :full       => 'April, 2010',
          :long       => 'April, 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '2010-04',
          :short      => '4/2010',
          :year       => 2010
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
          :year       => 2010
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
          :year       => 2010
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
          :full       => 'Monday, April 5, 2010',
          :long       => 'April 5, 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/5/2010',
          :short      => '4/5/2010',
          :year       => 2010
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
          :full       => 'Saturday, April 5, 0010',
          :long       => 'April 5, 10',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/5/10',
          :short      => '4/5/10',
          :year       => 10
        },
        :options => {
          :euro    => false
        }
      },
      '4/5/2010' => {
        :parsed_date => {
          :circa      => false,
          :day        => 4,
          :era        => 'AD',
          :fixed      => '4-5-2010',
          :full       => 'Tuesday, May 4, 2010',
          :long       => 'May 4, 2010',
          :month      => 5,
          :month_name => 'May',
          :original   => '4/5/2010',
          :short      => '5/4/2010',
          :year       => 2010
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
          :full       => 'April, 2010',
          :long       => 'April, 2010',
          :month      => 4,
          :month_name => 'April',
          :original   => '4/2010',
          :short      => '4/2010',
          :year       => 2010
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
          :year       => nil
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
          :full       => "June, 2015",
          :long       => "June, 2015",
          :month      => 6,
          :month_name => "June",
          :original   => "2015 June",
          :short      => "6/2015",
          :year       => 2015
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
          :full       => "Monday, June 15, 2015",
          :long       => "June 15, 2015",
          :month      => 6,
          :month_name => "June",
          :original   => "2015 June 15",
          :short      => "6/15/2015",
          :year       => 2015
        },
        :options    => {
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

end

