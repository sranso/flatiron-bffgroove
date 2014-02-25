class GroupCampaign < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :analytics_roi, :campaign_cost, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value, :campaigns
  has_many :campaigns

  def self.aggregate
    self.all.each do |group_campaign|
      GroupCampaign.columns_hash.each do |key,val|
        if val.type == :integer && key != "id"
          group_campaign[key] = group_campaign.campaigns.sum(key)
          group_campaign.save!
        end
      end
      group_campaign.calculate_open_rate
      group_campaign.calculate_send_date
      group_campaign.save!
    end
  end

  def calculate_open_rate
    self[:open_rate] = (self[:unique_opens].to_f/self[:successful_deliveries].to_f)*100.round(2)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |group_campaign|
        csv << group_campaign.attributes.values_at(*column_names)
      end
    end
  end

  def to_csv
    CSV.generate do |csv|
      csv << GroupCampaign.column_names
      csv << attributes.values_at(*GroupCampaign.column_names)
      campaigns.each do |campaign|
        csv << campaign.attributes.values_at(*GroupCampaign.column_names)
      end
    end
  end

  def calculate_send_date
    self.send_date = campaigns.order(:send_date)[0].send_date.strftime('%B %d, %Y')
  end 

end
