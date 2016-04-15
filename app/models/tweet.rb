class Tweet < ActiveRecord::Base
	belongs_to :twitter_account

	def get_handles 
		return text.scan /@([a-z0-9_]+)/i
	end

	def retweet?
		return text =~ /^RT @/
	end
end
