class Campaign < ActiveRecord::Base
  attr_accessible :title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :times_liked_on_facebook, :folder_id, :unique_id, :analytics_ROI, :campaign_cost, :revenue_created, :visits, :new_visits, :pages_visit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :per_visit_value, :average_value

  # require 'CSV'

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      row = convert(row)
      campaign = find_by_unique_id(row["unique_id"]) || new
      campaign.attributes = row.to_hash
      campaign.save!
    end
  end

  def self.convert(row)
    new_row = row
    new_row = row_to_i(5..12, new_row)
    new_row = row_to_i(14..15, new_row)
    new_row = row_to_i(17..21, new_row)
    new_row = row_to_i(26..27, new_row)
    new_row = row_to_i(33..33, new_row)
    new_row = row_to_f(13..13, new_row)
    new_row = row_to_f(16..16, new_row)
    new_row = row_to_f(23..25, new_row)
    new_row = row_to_f(28..29, new_row)
    new_row = row_to_f(31..32, new_row)
    new_row = row_to_f(34..36, new_row)
  end

  def self.row_to_i(range, new_row)
    array = *range
    i = array[0]
    debugger
    # .each no longer working because row is now a csv object
    #hard code column keys instead of range
    new_row[range].each do |column|
      new_row[i] = column.to_i
      i+=1
    end
    new_row
  end

  def self.row_to_f(range, new_row)
    array = *range
    i = array[0]
    new_row[range].each do |column|
      new_row[i] = column.to_f
      i+=1
    end
    new_row
  end


end