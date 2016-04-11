class TwitterAccountsController < ApplicationController

	# TODO authenticate

	def show
  	@twitter_account = TwitterAccount.find_by screenname: params[:id]

  	unless @twitter_account.nil?
  		#TODO update account if necessary
			config = {
			  consumer_key:    "HXxS12ZE5lzhMGnRNT3L9VYj0",
			  consumer_secret: "CMdVHbsn7PrxSwz0aeG8nb10vN1iCVMcH0vyDLKvpEvCDBAqfL",
			}

			# client = Twitter::REST::Client.new(config)
			# update_twitter_user(client, @twitter_account)

  	else
  		logger.info "Did not find account in database"
  		# TODO redirect to create then back here
  		@twitter_account = TwitterAccount.new
  		@twitter_account.screenname = params[:id]
  	end
  end


  def create
  	@twitter_account = TwitterAccount.find_by screenname: params[:twitter_account][:screenname]
  	success = true

  	if @twitter_account.nil?
	  	@twitter_account = TwitterAccount.new(twitter_account_params)
  		logger.info "Creating new account for " + @twitter_account.screenname
	  	success = @twitter_account.save
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

	  def update_tweets(client, twitter_account)
			# TODO async delete any old posts

	    options = {count: 25, include_rts: true}
			tweets = client.user_timeline(twitter_account.screenname, options)

			tweets.each do |tweet|
				tweet_data = {
					text: tweet.text,
					posted_at: tweet.created_at,
					retweets: tweet.retweet_count,
					likes: tweet.favorite_count
				}

				twitter_account.tweets.create(tweet)
			end
	  end

end
