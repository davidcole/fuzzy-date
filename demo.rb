require( 'rubygems' )
require( 'fuzzy-date' )

fuzzy_date = FuzzyDate::parse_date( '15 March 1971' )
puts fuzzy_date.inspect

