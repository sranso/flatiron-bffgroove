collection @group_campaign
attributes(:title, :subject, :list, :send_date, :send_weekday, :total_recipients, :successful_deliveries, :soft_bounces, :hard_bounces, :total_bounces, :times_forwarded, :forwarded_opens, :unique_opens, :open_rate, :total_opens, :unique_clicks, :click_rate, :total_clicks, :unsubscribes,:abuse_complaints, :unique_id, :revenue_created, :visits, :new_visits, :pagesvisit, :bounce_rate, :time_on_site, :goal_conversion_rate, :per_visit_goal_value, :transactions, :ecommerce_conversion_rate, :average_value)

node do |group_campaign|
  {
    :revenue_created => number_to_currency(group_campaign.revenue_created), 
    :open_rate => number_to_percentage(group_campaign.open_rate), 
    :click_rate => number_to_percentage(group_campaign.click_rate), 
    :bounce_rate => number_to_percentage(group_campaign.bounce_rate), 
    :goal_conversion_rate => number_to_percentage(group_campaign.goal_conversion_rate), 
    :ecommerce_conversion_rate => number_to_percentage(group_campaign.ecommerce_conversion_rate), :send_date => group_campaign.send_date.strftime('%m-%d-%Y')
  }
end