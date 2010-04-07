#!/usr/bin/env ruby -w

$:.unshift File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'test/unit'
require 'historical_date'

class ErrorTest < Test::Unit::TestCase

  def setup
    @test_dates = {
      'gibberish' => {
        :error => ArgumentError,
        :euro  => false
      },
      'Monday, 15 March, 2010' => {
        :error => ArgumentError,
        :euro  => false
      },
      '2010-23' => {
        :error => ArgumentError,
        :euro  => false
      }
    }
  end

  def test_errors
    @test_dates.each do | date, data |
      assert_raise( data[ :error ], "#{ date }#{ ' (euro)' if data[ :euro ] } didn't fail, as it should have." ){ HistoricalDate.parse_date( date ) }
    end
  end

end

