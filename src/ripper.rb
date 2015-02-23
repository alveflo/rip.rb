require 'open-uri'
require 'uri'
require 'fileutils'
load 'src/resource.rb'

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
			if (cssurl.match(/^http/) == nil)
				@resources << Resource.new(get_absolute_path(cssurl), cssurl)
			end
		end
	end

	def get_js_link(str)
		match = /src=".*\.js"/.match(str)
		if (match)
			jsurl = match[0]
				.gsub(/\"/,'')
				.gsub('src=', '')
			if (jsurl.match(/^http/) == nil)
				@resources << Resource.new(get_absolute_path(jsurl), jsurl)
			end
		end
	end

	def rip
		clone_html
		clone_resources
	end

	def ensure_folder(folder)
		begin
			dirname = folder
			if (dirname.include?('/'))
				dirname = File.dirname(folder)
			end

			unless File.directory?(dirname)
				puts "Creating folder #{dirname}"
				FileUtils::mkdir_p(dirname)
			end
		rescue
			puts "Unable to create folder #{folder}!"
		end
	end

	def clone_html
		ensure_folder(@destination)
		begin
			output = File.new("#{@destination}/index.htm", 'w')
			puts "Created file #{@destination}/index.htm"
			open(@url) {|f|
				f.each_line {|line|
					l = line.strip
					# Skip comments
					if (!/^<!--/.match(l))
						get_css_link(l)
						get_js_link(l)
					end
					output.puts line
				}
			}
		rescue SocketError
			puts "Unable to open web #{@url}!"
		rescue
			puts "Unable to create file #{@destination}/index.htm!"
		ensure
			output.close unless output.nil?
		end
	end

	def clone_resources
		@resources.each{ |res| 
			path = "#{@destination}#{res.relativeUrl}";
			ensure_folder(path)
			begin
				puts "\tCreating file #{path}"
				output = File.new(path, 'w')

				begin
					open(res.absoluteUrl) {|f|
						f.each_line {|line|
							output.puts line
						}
					}
				rescue SocketError
					puts "Unable to open resource #{res.absoluteUrl}!"
				end

			rescue
				puts "Unable to write to file #{path}!"
			ensure
				output.close unless output.nil?
			end
		}
	end

end