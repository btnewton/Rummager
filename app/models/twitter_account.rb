class TwitterAccount < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
	validates :screenname, presence: true, 
								uniqueness: true, length: { minimum: 1 }

	def to_param
    screenname
  end

	def requires_reload?
		if new_record? || name.nil?
			return true
		end

		return Time.now - updated_at > 1000 * 60 * 15
	end
end
