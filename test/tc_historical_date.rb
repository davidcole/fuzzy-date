#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'historical_date'

class HistoricalDateTest < Test::Unit::TestCase

  def test_date_gibberish
    date = 'gibberish'
    assert_raise( ArgumentError ){ HistoricalDate.parse_date( date ) }
  end

  def test_date_YYYY_MM_DD
    date = '2010-04-05'
    hd = HistoricalDate.parse_date( date )
    assert_equal( '2010-04-05', hd[ :fixed ] )
    assert_equal( 'April', hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_equal( 4, hd[ :month ] )
    assert_equal( 5, hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( 'Monday, April 5, 2010 AD', hd[ :full ] )
    assert_equal( '4/5/2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( 'April 5, 2010 AD', hd[ :long ] )
    assert_equal( date, hd[ :original ] )
    
    date = '2010 04 05 BC'
    hd = HistoricalDate.parse_date( date )
    assert_equal( '2010-04-05', hd[ :fixed ] )
    assert_equal( 'April', hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_equal( 4, hd[ :month ] )
    assert_equal( 5, hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( 'Tuesday, April 5, 2010 BC', hd[ :full ] )
    assert_equal( '4/5/2010 BC', hd[ :short ] )
    assert_equal( 'BC', hd[ :era ] )
    assert_equal( 'April 5, 2010 BC', hd[ :long ] )
    assert_equal( date, hd[ :original ] )
  end

  def test_date_YYYY_MM
    date = '2010-04'
    hd = HistoricalDate.parse_date( date )
    assert_equal( '2010-04', hd[ :fixed ] )
    assert_equal( 'April', hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_equal( 4, hd[ :month ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( 'April, 2010 AD', hd[ :full ] )
    assert_equal( '4/2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( 'April, 2010 AD', hd[ :long ] )
    assert_equal( date, hd[ :original ] )
    
    date = '2010-23'
    assert_raise( ArgumentError ){ HistoricalDate.parse_date( date ) }
  end

  def test_date_YYYY
    date = '2010'
    hd = HistoricalDate.parse_date( date )
    assert_equal( '2010', hd[ :fixed ] )
    assert_nil( hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_nil( hd[ :month ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( '2010 AD', hd[ :full ] )
    assert_equal( '2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( '2010 AD', hd[ :long ] )
    assert_equal( date, hd[ :original ] )
    
    date = '2010 BC'
    hd = HistoricalDate.parse_date( date )
    assert_equal( '2010', hd[ :fixed ] )
    assert_nil( hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_nil( hd[ :month ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( '2010 BC', hd[ :full ] )
    assert_equal( '2010 BC', hd[ :short ] )
    assert_equal( 'BC', hd[ :era ] )
    assert_equal( '2010 BC', hd[ :long ] )
    assert_equal( date, hd[ :original ] )
  end

end

