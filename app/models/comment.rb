# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment       :text
#  user_id    :integer
#  movie_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  after_save :after_save
  after_destroy :after_save

  private

  def after_save
    @cache_key = "Rewards_#{DateTime.now.to_s}"
    $redis.set("cache_key", @cache_key)
    rewards_service.update_rewards
  end

  def rewards_service
    @rewards_service ||= RewardsService.new
  end
end