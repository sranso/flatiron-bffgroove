class MailChimpCrawler
  def initialize
    @agent = Mechanize.new
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

  def download
    @agent.pluggable_parser.default = Mechanize::Download
    @agent.get('https://us5.admin.mailchimp.com/reports/export-all').save("main.csv")
  end

  def update_header
    header = "title,subject,list,send_date,send_weekday,total_recipients,successful_deliveries,soft_bounces,hard_bounces,total_bounces,times_forwarded,forwarded_opens,unique_opens,open_rate,total_opens,unique_clicks,click_rate,total_clicks,unsubscribes,abuse_complaints,times_liked_on_facebook,folder_id,unique_id,analytics_ROI,campaign_cost,revenue_created,visits,new_visits,pages_visit,bounce_rate,time_on_site,goal_conversion_rate,per_visit_goal_value,transactions,ecommerce_conversion_rate,per_visit_value,average_value"
    
    file.open("main.csv")

  end
end
