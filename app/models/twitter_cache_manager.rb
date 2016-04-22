class TwitterCacheManager

	CACHE_DURATION = 5 # minutes

	def initialize(twitter_account)
		@twitter_account = twitter_account
	end
	
	# Returns true if update successful
	def update
			config = {
			  consumer_key:    ENV["TWITTER_CONSUMER_KEY"],
			  consumer_secret: ENV["TWITTER_CONSUMER_SECRET"]
			}

			unless config[:consumer_key].nil? || config[:consumer_secret].nil?

				client = Twitter::REST::Client.new(config)
				
				if client.user? @twitter_account.screenname
					update_twitter_user(client, @twitter_account)
					update_tweets(client, @twitter_account)
				end

				return true
			else 
				logger.info "Twitter consumer key or secret not set in environment!"
				return false
			end
	end

		# indicates account should be reloaded if last load was > CACH_DURATION minutes ago
	def requires_reload?
		if @twitter_account.new_record? || @twitter_account.name.nil?
			return true
		end

		return Time.now - @twitter_account.updated_at > 60 * CACHE_DURATION
	end


	private
		def update_twitter_user(client, twitter_account)
  		twitter_account_data = client.user(twitter_account.screenname)

	  	twitter_account.name = twitter_account_data.name
	  	twitter_account.screenname = twitter_account_data.screen_name
	  	twitter_account.profile_picture_url = twitter_account_data.profile_image_url

	  	twitter_account.save
	  end

	  def update_tweets(client, twitter_account)
	    options = {count: 25, include_rts: true}
			tweets = client.user_timeline(twitter_account.screenname, options)

			tweets.each do |tweet|

				tweet_data = {
					text: tweet.text,
					posted_at: tweet.created_at,
					retweets: tweet.retweet_count,
					likes: tweet.favorite_count
				}

				unless tweet.media[0].nil?
					tweet_data[:media_url] = tweet.media[0]["media_url"]
				end

				twitter_account.tweets.create(tweet_data)
			end

			# TODO async delete any old posts

	  end

end
