require 'open-uri'
require 'uri'

class Scraper
	@url = nil
	@uri = nil
	@resources = nil

	def initialize(url)
		@url = url
		@uri = URI(url)
	end

	def get_css_link(str)
		match = /href=".*\.css"/.match(str)
		if (match)
			cssurl = match[0]
				.gsub(/\"/,'')
				.gsub('href=', '')
			p @uri.scheme + '://' + @uri.host + cssurl
		end
	end

	def get_js_link(str)
		match = /src=".*\.js"/.match(str)
		if (match)
			jsurl = match[0]
				.gsub(/\"/,'')
				.gsub('src=', '')
			p @uri.scheme + '://' + @uri.host + jsurl
		end
	end

	def scrape
		open(@url) {|f|
			f.each_line {|line|
				l = line.strip
				# Skip comments
				if (!/^<!--/.match(l))
					get_css_link(l)
					get_js_link(l)
				end
			}
		}
	end

end