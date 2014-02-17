class Groupaign < ActiveRecord::Base
  attr_accessible :title,:campaigns,:total_recipients,:successful_deliveries,:soft_bounces,:hard_bounces,:total_bounces,:times_forwarded,:forwarded_opens,:unique_opens,:total_opens,:unique_clicks,:total_clicks,:unsubscribes,:abuse_complaints,:times_liked_on_facebook,:folder_id,:visits,:new_visits,:transactions
  has_many :campaigns

  def self.aggregate
    self.all.each do |groupaign|
      Groupaign.columns_hash.each do |key,val| 
        if val.type == :integer && key != "id"
          groupaign[key] = groupaign.campaigns.sum(key)
          groupaign.save!
        end
      end
    end
  end

  # def self.reassign_nils
  #   empty = Groupaign.find_by_title("")
  #   empty.campaigns.each do |campaign|
  #     Campaign.find_by_subject(campaign.subject)
  #   end
  # end
  #SELECT SUM("campaigns"."total_recipients") AS sum_id FROM "campaigns" WHERE "campaigns"."groupaign_id" = 402

end
