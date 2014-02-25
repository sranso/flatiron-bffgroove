collection @group_campaigns
node do |group_campaign|
  {:title => "<a href=/group_campaigns/#{group_campaign.id}>#{group_campaign.title}</a>", :send_date => group_campaign.send_date.strftime('%B %d, %Y')}
end

