#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'historical_date'

class HistoricalDateTest < Test::Unit::TestCase

  def test_dates
    hd = HistoricalDate.parse_date( '2010-04-05' )
    assert_equal( hd[ :fixed ], '2010-04-05' )
    assert_equal( hd[ :month_name ], 'April' )
    assert_equal( hd[ :circa ], false )
    assert_equal( hd[ :month ], 4 )
    assert_nil( hd[ :errors ] )
    assert_equal( hd[ :day ], 5 )
    assert_equal( hd[ :year ], 2010 )
    assert_equal( hd[ :full ], 'Monday, April 5, 2010 AD' )
    assert_equal( hd[ :short ], '4/5/2010 AD' )
    assert_equal( hd[ :era ], 'AD' )
    assert_equal( hd[ :long ], 'April 5, 2010 AD' )
    assert_equal( hd[ :original ], '2010-04-05' )
  end

end

