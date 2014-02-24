class MailChimpCrawler
<<<<<<< HEAD
  def initialize
    @agent = Gibbon::API.new(API_KEY)
  end

  def log_in
    page = @agent.get('https://login.mailchimp.com/') do |login_page|
      form = login_page.form_with(:name => nil)
      username_field = form.field_with(:name => "username")
      username_field.value = ENV["THE_USERNAME"]
      password_field = form.field_with(:name => "password")
      password_field.value = ENV["THE_PASSWORD"]
      @agent.page.form.submit
      logged_in = @agent.page.form.submit
    end
  end
=======
  attr_reader :campaigns_response
>>>>>>> 6edc7f628c60c048fab37ed5a7115d2b82b50678

  def initialize
    response = HTTParty.get("https://us5.api.mailchimp.com/2.0/campaigns/list?apikey=#{ENV['API_KEY']}")
    @campaigns_response = response["data"]
  end

end
