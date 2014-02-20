class GroupCampaign < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :times_liked_on_facebook, :folder_id, :unique_id, :analytics_roi, :campaign_cost, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value, :campaigns
  has_many :campaigns

  searchable do 
    text :title, :subject, :list
  end

  def self.aggregate
    self.all.each do |group_campaign|
      GroupCampaign.columns_hash.each do |key,val|
        if val.type == :integer && key != "id"
          group_campaign[key] = group_campaign.campaigns.sum(key)
          group_campaign.save!
        end
      end
      group_campaign.calculate_open_rate
      group_campaign.save!
    end
  end

  def calculate_open_rate
    self[:open_rate] = (self[:unique_opens].to_f/self[:successful_deliveries].to_f)*100.round(2)
  end

  # def self.search_engine(search)
  #   title_results = []
  #   self.all.each do |group_campaign|
  #     title_results << group_campaign if group_campaign.title.include?(search) 
  #   end 
  #   title_results
  # end 
  
  # def self.reassign_nils
  #   empty = GroupCampaign.find_by_title("")
  #   empty.campaigns.each do |campaign|
  #     Campaign.find_by_subject(campaign.subject)
  #   end
  # end
  #SELECT SUM("campaigns"."total_recipients") AS sum_id FROM "campaigns" WHERE "campaigns"."group_campaign_id" = 402

end
