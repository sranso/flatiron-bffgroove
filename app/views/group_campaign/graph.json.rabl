collection @weekdays
node :weekday do |m|
  m
end

@group_campaigns.each do |group_campaign|
  node(group_campaign.title.to_sym, :if => lambda {|m| group_campaign.send_weekday == m}) do
    group_campaign.revenue_created 
  end
end

