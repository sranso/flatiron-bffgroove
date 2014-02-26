class Campaign < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :title, :subject, :list_id, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :analytics_roi, :campaign_cost, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value, :group_campaign_id, :folder_id
  has_one :group_campaign
  belongs_to :list
  attr_reader :api

  def self.get_api_response
    @@api.all_campaigns
  end

  def self.google_analytics(campaign_id)
    @@api.google_analytics(campaign_id)
  end

  def self.import_response
    @@api = MailChimpCrawler.new
    response = get_api_response
    response.each do |campaign|
      current_campaign = find_by_unique_id(campaign["id"]) || new
      current_campaign[:unique_id] = campaign["id"]

      current_campaign[:send_date] = campaign["send_time"]
      current_campaign[:total_recipients] = campaign["emails_sent"]
      current_campaign[:times_forwarded] = campaign["summary"]["forwards"] if campaign["summary"]["forwards"].class == Integer
      current_campaign[:total_opens] = campaign["summary"]["opens"]
      current_campaign[:total_clicks] = campaign["summary"]["clicks"]
      current_campaign[:abuse_complaints] = campaign["summary"]["abuse_reports"]

      google_analytics_hash = google_analytics(current_campaign.unique_id)
      if google_analytics_hash["revenue"]
        current_campaign[:revenue_created] = google_analytics_hash["revenue"].to_f
        conversion_rate = google_analytics_hash["ecomm_conversions"].to_f / current_campaign[:total_recipients]
        current_campaign[:ecommerce_conversion_rate] = conversion_rate
        google_analytics_hash.each do |key, val|
          current_campaign.set_attributes(key, val)
        end
      end
      
      campaign.each do |key, val|
        if key == "summary"
          val.each do |key2, val2|
            if key2 == "industry"
              val2.each do |key3, val3|
                current_campaign.set_attributes(key3, val3)
              end
            else
              current_campaign.set_attributes(key2, val2)
            end
          end
        elsif key == "list_id"
          list = List.find_by_list_id(val)
          list.campaigns << current_campaign
          list.save!
        else
          current_campaign.set_attributes(key, val)
        end
      end
    end
  end

  def set_attributes(key, val)
    if Campaign.column_names.include?(key) && key != "id"
      if Campaign.columns_hash[key].type == :integer
        val = val.to_i
      elsif Campaign.columns_hash[key].type == :decimal
        val = val.to_f
      end
      update_attributes(key.to_sym => val)
    end
  end

  def self.group_campaigns
    self.all.each do |campaign|
      if /(.*) \(/.match(campaign["title"])
        title = /(.*) \(/.match(campaign["title"])[1]
      else
        title = campaign.title 
      end
      group_campaign = GroupCampaign.find_or_create_by_title(title)
      group_campaign.campaigns << campaign
      group_campaign.save! 
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |campaign|
        csv << campaign.attributes.values_at(*column_names)
      end
    end
  end

end