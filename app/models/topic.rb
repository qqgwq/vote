class Topic < ApplicationRecord
  include Redis::Objects
  sorted_set :ranks, global: true
  set :vote
  mount_uploader :avatar, AvatarUploader
  after_create :init_score

  #定时清理set中的用户
  def self.vote_user
    Topic.all.each do |topic|
      topic.vote.clear
    end
  end

  #排名
  def rankes
    ranks.revrank(self.id)&.next
  end

  #点赞数
  def vote_score
    ranks.score(self.id).to_i
  end

  private

  #回调创建文章之前初始化redis的值不能为空
  def init_score
    ranks.incr(self.id, 0)
  end
end
