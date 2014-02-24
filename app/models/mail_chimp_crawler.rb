class MailChimpCrawler
  attr_reader :campaigns_response

  def initialize
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/campaigns/list?apikey=#{ENV['API_KEY']}")
    @campaigns_response = response["data"]
  end

end