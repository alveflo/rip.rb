require 'optparse'

class Cliparser
	def parse(args)
		hash = {}
		pattern = /^--?/
		for a in 0..(args.length-1)
			if (pattern.match(args[a]) != nil)
				if (a != args.length-1 and pattern.match(args[a+1]) == nil)
					hash[args[a].gsub('-', '')] = args[a+1]
				end
			end
		end
		return hash
	end
end