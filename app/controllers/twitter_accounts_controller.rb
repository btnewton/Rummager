class TwitterAccountsController < ApplicationController

	before_action :authenticate_user!

	def index
		redirect_to action: "show", id: "rails"
	end

	def show
		screenname = sanitize_twitter_handle(params[:id])
  	@twitter_account = TwitterAccount.where("lower(screenname) = ?", screenname.downcase).first

  	if @twitter_account.nil?
  		@twitter_account = TwitterAccount.create(screenname: screenname)
  	end

  	if @twitter_account.requires_reload?
			logger.info "Reloading data for #{params[:id]}"

			config = {
			  consumer_key:    ENV["TWITTER_CONSUMER_KEY"],
			  consumer_secret: ENV["TWITTER_CONSUMER_SECRET"]
			}

			client = Twitter::REST::Client.new(config)
			
			# TODO handle errors
			# begin
				update_twitter_user(client, @twitter_account)
				update_tweets(client, @twitter_account)
			# rescue Twitter::Error::Forbidden: e
				# logger.info "Forbidden exception raised while trying to access #{screenname}"
			# end
  	end

  	@handles = Hash.new
  	@twitter_account.tweets.each do |tweet|
  		tweet_handles = tweet.get_handles
  		if tweet_handles.any?
  			@handles.concat tweet_handles
  		end
  	end
  end


  def create
  	screenname = sanitize_twitter_handle(params[:twitter_account][:screenname])
  	@twitter_account = TwitterAccount.where("lower(screenname) = ?", screenname.downcase).first
  	success = true

  	if @twitter_account.nil?
	  	@twitter_account = TwitterAccount.create(twitter_account_params)
	  	success = !@twitter_account.new_record?
 		end

	  if success
	  	redirect_to @twitter_account
	  else
	  	render 'show'
	  end
  end


	private
	  def twitter_account_params
	    params.require(:twitter_account).permit(:screenname)
	  end

	  def update_twitter_user(client, twitter_account)
  		twitter_account_data = client.user(twitter_account.screenname)

	  	twitter_account.name = twitter_account_data.name
	  	twitter_account.screenname = twitter_account_data.screen_name
	  	twitter_account.profile_picture_url = twitter_account_data.profile_image_url

	  	twitter_account.save
	  end

	  def sanitize_twitter_handle(handle)
	  	return handle.gsub(/[^0-9a-z ]/i, '')
	  end

	  def update_tweets(client, twitter_account)
	    options = {count: 25, include_rts: true}
			tweets = client.user_timeline(twitter_account.screenname, options)

			tweets.each do |tweet|
				logger.info tweet
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
