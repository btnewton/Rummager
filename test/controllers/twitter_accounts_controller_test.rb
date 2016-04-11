require 'test_helper'

class TwitterAccountControllerTest < ActionController::TestCase

	def show
  	@search = Search.find_by author: params[:id]
  	
  	if (@search == nil)
  		@search = Search.new
  		@search.author = params[:id]
  	else
			config = {
			  consumer_key:    "HXxS12ZE5lzhMGnRNT3L9VYj0",
			  consumer_secret: "CMdVHbsn7PrxSwz0aeG8nb10vN1iCVMcH0vyDLKvpEvCDBAqfL",
			}

			# TODO catch errors
			client = Twitter::REST::Client.new(config)
	    options = {count: 25, include_rts: true}
			@tweets = client.user_timeline(@search.author, options)
  	end
  end

  def create
	  @search = Search.new(search_params)
	  @search.result = "SDFSDFSF"
 
	  if @search.save
	  	redirect_to @search
	  else
	  	render 'show'
	  end
  end

	private
	  def search_params
	    params.require(:search).permit(:author)
	  end
end
