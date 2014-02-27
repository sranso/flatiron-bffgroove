collection @campaigns
attributes(:title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :revenue_created, :visits, :new_visits, :bounce_rate, :transactions, :ecommerce_conversion_rate)

node do |campaign|
  {
    :revenue_created => number_to_currency(campaign.revenue_created, delimeter: ","), 
    :total_recipients => number_with_delimiter(campaign.total_recipients),
    :successful_deliveries => number_with_delimiter(campaign.successful_deliveries),
    :unique_opens => number_with_delimiter(campaign.unique_opens),
    :total_opens => number_with_delimiter(campaign.total_opens),
    :total_clicks => number_with_delimiter(campaign.total_clicks),
    :total_recipients => number_with_delimiter(campaign.total_recipients),
    :unique_clicks => number_with_delimiter(campaign.unique_clicks),
    :open_rate => number_to_percentage(campaign.open_rate, precision: 2), 
    :click_rate => number_to_percentage(campaign.click_rate), 
    :bounce_rate => number_to_percentage(campaign.bounce_rate, precision: 2), 
    :ecommerce_conversion_rate => number_to_percentage(campaign.ecommerce_conversion_rate, precision: 2), 
    :send_date => campaign.send_date.strftime('%m-%d-%Y %I:%M'),
    :list => List.find(campaign.list_id).name
  }
end 
