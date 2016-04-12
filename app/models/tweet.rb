class Tweet < ActiveRecord::Base
	belongs_to :twitter_account

	def retweet?
		return text =~ /^RT @/
	end

	def wrap_links
		urls = %r{(?:https?)://\S+}i
		return text.gsub(urls, '<a href="\0">\0</a>')
	end

	def wrap_handles

	end
end
