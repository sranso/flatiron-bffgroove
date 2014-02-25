collection @group_campaigns
node do |group_campaign|
  {:title => "<a href=/group_campaigns/#{group_campaign.id}>#{group_campaign.title}</a>"}
end
attributes(:send_date)