class Campaign < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :times_liked_on_facebook, :folder_id, :unique_id, :analytics_roi, :campaign_cost, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value, :group_campaign_id
  has_one :group_campaign

  def self.get_api_response
    api = MailChimpCrawler.new
  end

  def self.get_google_analytics(campaign_id)
    api = MailChimpCrawler.new
    api.get_google_analytics(campaign_id)
  end

  def self.response_import
    response = self.get_api_response
    response.each do |campaign|
      current_campaign = find_by_unique_id(campaign["id"]) || new
      get_google_analytics(current_campaign.unique_id).each do |key, val|
        current_campaign[:revenue_created] = "revenue"
        current_campaign[:ecommerce_conversion_rate] = "ecomm_conversions"
        current_campaign.set_attributes(key, val)
      end
      current_campaign[:send_date] = campaign["send_time"]
      current_campaign[:total_recipients] = campaign["emails_sent"]
      current_campaign[:times_forwarded] = campaign["summary"]["forward"]
      current_campaign[:total_opens] = campaign["summary"]["opens"]
      current_campaign[:total_clicks] = campaign["summary"]["clicks"]
      current_campaign[:abuse_complaints] = campaign["summary"]["abuse_reports"]
      current_campaign[:times_liked_on_facebook] = campaign["summary"]["facebook_likes"]
      current_campaign[:unique_id] = campaign["summary"]["id"]
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
      update_attributes(key => val)
    end
  end
  
  def self.import(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      row = convert(row)
      campaign = find_by_unique_id(row[:unique_id]) || new
      campaign.attributes = row.to_hash
      campaign.save!
    end
  end

  def self.convert(row)
    integer_array = [:total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :total_opens, :unique_clicks, :total_clicks, :unsubscribes,:abuse_complaints, :times_liked_on_facebook, :folder_id, :visits, :new_visits,:transactions]

    decimal_array = [:open_rate, :analytics_roi, :campaign_cost, :revenue_created, :bounce_rate, :goal_conversion_rate, :per_visit_goal_value, :ecommerce_conversion_rate, :per_visit_value, :average_value]

    integer_array.each do |key|
      row[key] = row[key].to_i
    end 

    decimal_array.each do |key|
      row[key] = row[key].gsub("$","").to_f if row[key]
    end
    row
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