class Tweet < ActiveRecord::Base
	belongs_to :twitter_account

	def retweet?
		return text =~ /^RT @/
	end
end
