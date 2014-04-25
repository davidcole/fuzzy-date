require( 'rubygems' )
require( 'fuzzy-date' )

fuzzy_date = FuzzyDate::parse( '15 March 1971' )

puts "PARSING: #{ fuzzy_date.original }"

puts "Short date:     #{ fuzzy_date.short       }"
puts "Long date:      #{ fuzzy_date.long        }"
puts "Full date:      #{ fuzzy_date.full        }"
puts "Year:           #{ fuzzy_date.year        }"
puts "Month:          #{ fuzzy_date.month       }"
puts "Day:            #{ fuzzy_date.day         }"
puts "Month name:     #{ fuzzy_date.month_name  }"
puts "Circa:          #{ fuzzy_date.circa       }"
puts "Era:            #{ fuzzy_date.era         }"

fuzzy_date = FuzzyDate::parse( '15 March' )

puts "PARSING: #{ fuzzy_date.original }"

puts "Short date:     #{ fuzzy_date.short       }"
puts "Long date:      #{ fuzzy_date.long        }"
puts "Full date:      #{ fuzzy_date.full        }"

puts "Original date:  #{ fuzzy_date.original    }"
puts "Year:           #{ fuzzy_date.year        }"
puts "Month:          #{ fuzzy_date.month       }"
puts "Day:            #{ fuzzy_date.day         }"
puts "Month name:     #{ fuzzy_date.month_name  }"
puts "Circa:          #{ fuzzy_date.circa       }"
puts "Era:            #{ fuzzy_date.era         }"

fuzzy_date = FuzzyDate::parse( 'About March 1971' )

puts "PARSING: #{ fuzzy_date.original }"

puts "Short date:     #{ fuzzy_date.short       }"
puts "Long date:      #{ fuzzy_date.long        }"
puts "Full date:      #{ fuzzy_date.full        }"

puts "Original date:  #{ fuzzy_date.original    }"
puts "Year:           #{ fuzzy_date.year        }"
puts "Month:          #{ fuzzy_date.month       }"
puts "Day:            #{ fuzzy_date.day         }"
puts "Month name:     #{ fuzzy_date.month_name  }"
puts "Circa:          #{ fuzzy_date.circa       }"
puts "Era:            #{ fuzzy_date.era         }"

fuzzy_date = FuzzyDate::parse( '1971 BC' )

puts "PARSING: #{ fuzzy_date.original }"

puts "Short date:     #{ fuzzy_date.short       }"
puts "Long date:      #{ fuzzy_date.long        }"
puts "Full date:      #{ fuzzy_date.full        }"

puts "Original date:  #{ fuzzy_date.original    }"
puts "Year:           #{ fuzzy_date.year        }"
puts "Month:          #{ fuzzy_date.month       }"
puts "Day:            #{ fuzzy_date.day         }"
puts "Month name:     #{ fuzzy_date.month_name  }"
puts "Circa:          #{ fuzzy_date.circa       }"
puts "Era:            #{ fuzzy_date.era         }"
