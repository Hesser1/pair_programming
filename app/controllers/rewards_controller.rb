class RewardsController < ApplicationController
  def index
    @rewards = rewards_service.get_rewards
  end

  private

  def rewards_service
    @rewards_service ||= RewardsService.new
  end
end