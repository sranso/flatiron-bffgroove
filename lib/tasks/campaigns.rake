task :import => :environment do
  Campaign.import_response
  Campaign.group_campaigns
  GroupCampaign.aggregate
end