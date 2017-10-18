class Topic < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liked_user, through: :likes, source: :user

  def liked_topic?(user)
    self.likes.where(user_id: user).first
  end
end
