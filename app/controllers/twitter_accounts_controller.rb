class TwitterAccountsController < ApplicationController

	before_action :authenticate_user!

	def index
		redirect_to action: "show", id: "rails"
	end

	def show
		screenname = TwitterAccount.sanitize_handle params[:id]
  	@twitter_account = TwitterAccount.where("lower(screenname) = ?", screenname.downcase).first
		@success = true

  	if @twitter_account.nil?
  		@twitter_account = TwitterAccount.create(screenname: screenname)
  	end

  	cache_manager = TwitterCacheManager.new @twitter_account

  	if cache_manager.requires_update?
			@success = cache_manager.update
  	end
  end


  def create
  	screenname = TwitterAccount.sanitize_handle params[:twitter_account][:screenname]
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
 
end
