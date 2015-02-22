#!/usr/bin/env/ruby -w
load 'cliparser.rb'
load 'scraper.rb'

parser = Cliparser.new

args = parser.parse(ARGV)
url = nil
if (args['u'])
	url = args['u']
elsif (args['url'])
	url = args['url']
else
	p 'An URL was not given.'
	p 'Syntax: ripper.rb -u/--url <url>'
	exit
end

scraper = Scraper.new(url)

scraper.scrape