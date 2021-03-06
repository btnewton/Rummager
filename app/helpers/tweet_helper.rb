module TweetHelper

	def prep_tweet_content(tweet)
		text = wrap_links(tweet.text)
		
		if tweet.retweet?
			text = text[2, text.length]
		end

		text = wrap_handles(text)


		return text.html_safe
	end

	def get_handles(tweets)
		handles = []
		
		tweets.each do |tweet|
			tweet_handles = tweet.get_handles
  		if tweet_handles.any?
  			handles.concat tweet_handles
  		end
		end

		return handles
	end

	def wrap_links(text)
		urls = %r{(?:https?)://\S+}i
		return text.gsub(urls, '<a href="\0">\0</a>')
	end

	def wrap_handles(text)
		handles = /@([a-z0-9_]+)/i
		return text.gsub(handles, '<a href="\0" class="handler">\0</a>')
	end
end
