class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, uniqueness: true

	def to_param
    screenname
  end

	def is_invalid
		if new_record?
			return true
		end

		return Time.now - updated_at > 1000 * 60 * 15
	end
end
