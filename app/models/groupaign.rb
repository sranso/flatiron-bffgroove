class Groupaign < ActiveRecord::Base
  attr_accessible :title,:campaigns,:total_recipients,:successful_deliveries,:soft_bounces,:hard_bounces,:total_bounces,:times_forwarded,:forwarded_opens,:unique_opens,:total_opens,:unique_clicks,:total_clicks,:unsubscribes,:abuse_complaints,:times_liked_on_facebook,:folder_id,:visits,:new_visits,:transactions
  has_many :campaigns

  def self.aggregate
    self.all.each do |groupaign|
      groupaign.columns_hash.each do |key, value|
        Campaign.columns_hash.each { |k,v| arr << v.type == :integer }
      end
      groupaign.total_recipients = groupaign.campaigns.sum("total_recipients")
      groupaign.save!
    end
  end

  def method_name
    
  end

  # def self.reassign_nils
  #   empty = Groupaign.find_by_title("")
  #   empty.campaigns.each do |campaign|
  #     Campaign.find_by_subject(campaign.subject)
  #   end
  # end

end
