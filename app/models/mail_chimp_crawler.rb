class MailChimpCrawler

  def all_campaigns
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/campaigns/list?apikey=#{ENV['API_KEY']}")
    response["data"]
  end

  def google_analytics(campaign_id)
    HTTParty.get("https://us5.api.mailchimp.com/2.0/reports/google-analytics?apikey=#{ENV['API_KEY']}&cid=#{campaign_id}")
  end

  def list_name(list_id)
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/lists/list?apikey=#{ENV['API_KEY']}&filters[list_id]=#{list_id}")
    response["data"][0]["name"]
  end

end
