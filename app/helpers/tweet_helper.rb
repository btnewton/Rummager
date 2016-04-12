module TweetHelper

	def prep_tweet_content(tweet)
		text = wrap_links(tweet.text)
		text = wrap_handles(text)
		return text.html_safe
	end

	def wrap_links(text)
		urls = %r{(?:https?)://\S+}i
		return text.gsub(urls, '<a href="\0">\0</a>')
	end

	def wrap_handles(text)
		urls = %r{RT @\S+:}i
		return text.gsub(urls, '<a href="\0">\0</a>')
	end

end
