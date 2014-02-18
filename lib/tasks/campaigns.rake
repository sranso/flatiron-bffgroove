task :download => :environment do 
  page = MailChimpCrawler.new
  page.log_in
  page.download
end

task :import => :environment do
  Campaign.import("main.csv")
  Campaign.group_campaigns
end
