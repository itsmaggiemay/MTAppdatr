class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tweets

  def self.save_tag_data(tag, user_id)
    self.create_with(text: tag).find_or_create_by(user_id: user_id)
  end

end
