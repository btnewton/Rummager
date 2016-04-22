class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, 
								length: { minimum: 1 },
								uniqueness: { case_sensitive: false }
	MAX_TWEET_COUNT = 25

	def to_param
    screenname
  end

  def get_tweets count = MAX_TWEET_COUNT
  	count = [count, MAX_TWEET_COUNT].min
  	return tweets.last(count)
  end
  
end
