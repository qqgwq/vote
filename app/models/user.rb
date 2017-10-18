class User < ApplicationRecord
  include Redis::Objects
  sorted_set :ranks, global: true
  has_secure_password
  mount_uploader :image, ImageUploader
  has_many :topics
  has_many :likes
  has_many :likes, through: :likes, source: :topic
  validates :name, :password, :image, presence: true
end
