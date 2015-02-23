#!/usr/bin/env/ruby -w
load 'src/cliparser.rb'
load 'src/ripper.rb'

parser = Cliparser.new

args = parser.parse(ARGV)
url = nil
out = nil
if (args['u'])
	url = args['u']
elsif (args['url'])
	url = args['url']
else
	puts 'An URL was not given.'
	puts 'Syntax: rip.rb -u/--url <url> -p/--path <output path>'
	exit
end

if (args['p'])
	out = args['p']
elsif (args['path'])
	out = args['path']
else
	puts 'An output path was not given.'
	puts 'Syntax: rip.rb -u/--url <url> -p/--path <output path>'
	exit
end


Ripper.new(url, out).rip