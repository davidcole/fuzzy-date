load 'lib/fuzzy-date.rb'

[ '15 March 1971',
  '15 March',
  'About March 1971',
  '1971 BC' ].each do |date|

  fuzzy_date = FuzzyDate::parse( date )

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
  puts "Sortable:       #{ fuzzy_date.sortable    }"
end
