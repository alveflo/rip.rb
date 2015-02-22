require 'open-uri'
require 'uri'
require 'fileutils'
load 'resource.rb'

class Ripper
	def initialize(url, destination)
		@destination = destination
		@url = url
		@uri = URI(url)
		@resources = []
	end

	def get_absolute_path(path)
		return "#{@uri.scheme}://#{@uri.host}#{path}"
	end

	def get_css_link(str)
		match = /href=".*\.css"/.match(str)
		if (match)
			cssurl = match[0]
				.gsub(/\"/,'')
				.gsub('href=', '')
			@resources << Resource.new(get_absolute_path(cssurl), cssurl)
		end
	end

	def get_js_link(str)
		match = /src=".*\.js"/.match(str)
		if (match)
			jsurl = match[0]
				.gsub(/\"/,'')
				.gsub('src=', '')
			@resources << Resource.new(get_absolute_path(jsurl), jsurl)
		end
	end

	def rip
		clone_html
		clone_resources
	end

	def ensure_folder(folder)
		dirname = folder
		if (dirname.include?('/'))
			dirname = File.dirname(folder)
		end

		unless File.directory?(dirname)
			puts "Creating folder #{dirname}"
			FileUtils::mkdir_p(dirname)
		end
	end

	def clone_html
		ensure_folder(@destination)
		output = File.new("#{@destination}/index.htm", 'w')
		open(@url) {|f|
			f.each_line {|line|
				l = line.strip
				# Skiputs comments
				if (!/^<!--/.match(l))
					get_css_link(l)
					get_js_link(l)
				end
				output.puts line
			}
		}
		output.close
	end

	def clone_resources
		@resources.each{ |res| 
			path = "#{@destination}#{res.relativeUrl}";
			ensure_folder(path)

			puts "\tCreating file #{path}"
			output = File.new(path, 'w')
			open(res.absoluteUrl) {|f|
				f.each_line {|line|
					output.puts line
				}
			}
			output.close
		}
	end

end