class User < ApplicationRecord
  #include Redis::Objects
  has_secure_password
  mount_uploader :image, ImageUploader
  has_many :likes
  #has_many :likes, through: :likes, source: :topic
  validates :name, :password, presence: true

   def self.search(search)
    if search
      User.where("name LIke? OR id LIKE?", "%#{search}%", "%#{search}%")
    else
      User.all
    end
  end

  def admin?
    self.role == 'admin'
  end

  def rankes
    ranks.revrank(self.id)&.next
  end
end
