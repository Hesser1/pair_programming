class RewardsService
  def initialize
    @cache_key = $redis.get("cache_key") rescue nil
    if @cache_key.nil?
      @cache_key = "Rewards_#{DateTime.now.to_s}"
      $redis.set("cache_key", @cache_key)
    end
  end

  def update_rewards
    summary = Comment
                  .where(:created_at => (Date.today - 7.days).beginning_of_day.to_datetime..Date.today.end_of_day.to_datetime)
                  .select(:user_id, "count(id) as count")
                  .group(:user_id)
                  .order("count desc")
                  .limit(10)
    @rewards = summary.map { |it|
      {
          "name": User.find(it["user_id"]).name,
          "count": it["count"]
      }
    }
    $redis.set(@cache_key, @rewards.to_json)
    @rewards
  end

  def get_rewards
    @rewards = JSON.parse($redis.get(@cache_key)) rescue nil
    update_rewards if @rewards.nil?
    @rewards
  end
end