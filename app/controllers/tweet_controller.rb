class TweetController < ApplicationController
	before_action :authenticate_user!
end
