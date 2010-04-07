#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'historical_date'

class HistoricalDateTest < Test::Unit::TestCase

  def test_date_YYYY_MM_DD
    hd = HistoricalDate.parse_date( '2010-04-05' )
    assert_equal( '2010-04-05', hd[ :fixed ] )
    assert_equal( 'April', hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_equal( 4, hd[ :month ] )
    assert_nil( hd[ :errors ] )
    assert_equal( 5, hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( 'Monday, April 5, 2010 AD', hd[ :full ] )
    assert_equal( '4/5/2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( 'April 5, 2010 AD', hd[ :long ] )
    assert_equal( '2010-04-05', hd[ :original ] )
  end

  def test_date_YYYY_MM
    hd = HistoricalDate.parse_date( '2010-04' )
    assert_equal( '2010-04', hd[ :fixed ] )
    assert_equal( 'April', hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_equal( 4, hd[ :month ] )
    assert_nil( hd[ :errors ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( 'April, 2010 AD', hd[ :full ] )
    assert_equal( '4/2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( 'April, 2010 AD', hd[ :long ] )
    assert_equal( '2010-04', hd[ :original ] )
  end

  def test_date_YYYY
    hd = HistoricalDate.parse_date( '2010' )
    assert_equal( '2010', hd[ :fixed ] )
    assert_nil( hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_nil( hd[ :month ] )
    assert_nil( hd[ :errors ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( '2010 AD', hd[ :full ] )
    assert_equal( '2010 AD', hd[ :short ] )
    assert_equal( 'AD', hd[ :era ] )
    assert_equal( '2010 AD', hd[ :long ] )
    assert_equal( '2010', hd[ :original ] )
    
    hd = HistoricalDate.parse_date( '2010 BC' )
    assert_equal( '2010', hd[ :fixed ] )
    assert_nil( hd[ :month_name ] )
    assert_equal( false, hd[ :circa ] )
    assert_nil( hd[ :month ] )
    assert_nil( hd[ :errors ] )
    assert_nil( hd[ :day ] )
    assert_equal( 2010, hd[ :year ] )
    assert_equal( '2010 BC', hd[ :full ] )
    assert_equal( '2010 BC', hd[ :short ] )
    assert_equal( 'BC', hd[ :era ] )
    assert_equal( '2010 BC', hd[ :long ] )
    assert_equal( '2010 BC', hd[ :original ] )
  end

end

