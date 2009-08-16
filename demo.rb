require( 'rubygems' )
require( 'historical_date' )

historical_date = HistoricalDate::parse_date( '15 March 1971' )
puts historical_date.inspect

