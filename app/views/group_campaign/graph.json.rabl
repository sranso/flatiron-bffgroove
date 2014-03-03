collection @weekdays
node(:weekday){|m| m}

@group_campaigns.each do |group_campaign|
  if group_campaign.send_weekday == "Friday"
    node group_campaign.title.to_sym do 
    end
  end
end
