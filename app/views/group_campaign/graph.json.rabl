collection @group_campaigns
attributes(:title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :unique_opens, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :revenue_created, :visits, :new_visits, :bounce_rate, :transactions, :ecommerce_conversion_rate)

node do |group_campaign|
  {
    :revenue_created => number_to_currency(group_campaign.revenue_created, delimeter: ","), 
    :total_recipients => number_with_delimiter(group_campaign.total_recipients),
    :successful_deliveries => number_with_delimiter(group_campaign.successful_deliveries),
    :unique_opens => number_with_delimiter(group_campaign.unique_opens),
    :total_opens => number_with_delimiter(group_campaign.total_opens),
    :total_clicks => number_with_delimiter(group_campaign.total_clicks),
    :total_recipients => number_with_delimiter(group_campaign.total_recipients),
    :unique_clicks => number_with_delimiter(group_campaign.unique_clicks),
    :click_rate => number_to_percentage(group_campaign.click_rate), 
    :bounce_rate => number_to_percentage(group_campaign.bounce_rate, precision: 2), 
    :ecommerce_conversion_rate => number_to_percentage(group_campaign.ecommerce_conversion_rate, precision: 2), 
    :send_date => group_campaign.send_date.strftime('%m-%d-%Y')
  }
end 