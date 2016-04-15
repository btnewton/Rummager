class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, 
								length: { minimum: 1 },
								uniqueness: { case_sensitive: false }
	CACHE_DURACTION = 5 # minutes
	MAX_TWEET_COUNT = 25

	def to_param
    screenname
  end

	# indicates account should be reloaded if last load was > CACH_DURACTION minutes ago
	def requires_reload?
		if new_record? || name.nil?
			return true
		end

		return Time.now - updated_at > 60 * CACHE_DURACTION
	end
end
