class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, 
								length: { minimum: 1 },
								uniqueness: { case_sensitive: false }
	MAX_TWEET_COUNT = 25

	def to_param
    screenname
  end
  
end
