class Campaign < ActiveRecord::Base
  attr_accessible :title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :times_liked_on_facebook, :folder_id, :unique_id, :analytics_ROI, :campaign_cost, :revenue_created, :visits, :new_visits, :pages_visit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value

  # require 'CSV'

  def self.import(file)
    CSV.foreach(file) do |row|
      debugger
      row = convert(row)
      debugger
      campaign = find_by_unique_id(row["unique_id"]) || new
      campaign.attributes = row.to_hash
      debugger
      campaign.save!
    end
  end

  def convert(row)
    new_row = row
    i = 5
    row_time(5..12, new_row)
    # row[5..12].each do |column|
    #   new_row[i] = column.to_i
    #   i+=1
    # end
    new_row
  end

  def row_time(range, new_row)
    i = range[0]
    new_row[range].each do |column|
      new_row[i] = column.to_i
      i+=1
    end
    new_row
  end
end