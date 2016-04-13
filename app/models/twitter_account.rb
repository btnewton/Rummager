class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, 
								length: { minimum: 1 },
								uniqueness: { case_sensitive: false }

	def to_param
    screenname
  end

	def requires_reload?
		if new_record? || name.nil?
			return true
		end

		return Time.now - updated_at > 1000 * 60 * 5
	end
end
