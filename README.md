## fuzzy-date

The fuzzy-date gem provides a way to parse and use incomplete dates, like those found in history or genealogy.

For example, if you know your great-great-great grandmother was born in April, 1836, but you don't know the day of the month, that's not going to work if you try to parse it as a Date object.

With fuzzy-date, when you parse an incomplete date, you'll be given an object of information about the date.

## Installation

  `gem install fuzzy-date`

## Usage:

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

## Contributing

If you'd like to hack on FuzzyDate - and we hope you do! - start by forking the repo on GitHub:

https://github.com/davidcole-fuzzydate

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, I'll take care of that
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch

## License

fuzzy-date is released under the [MIT License](http://www.opensource.org/licenses/MIT).

## Code Status

[![Build Status](https://travis-ci.org/davidcole/fuzzy-date.svg?branch=master)](https://travis-ci.org/davidcole/fuzzy-date)