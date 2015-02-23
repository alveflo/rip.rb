class Resource
	attr_reader :absoluteUrl,:relativeUrl
	def initialize(absoluteUrl, relativeUrl)
		@absoluteUrl = absoluteUrl
		@relativeUrl = relativeUrl
	end
end 