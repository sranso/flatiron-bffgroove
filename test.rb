require 'mechanize'

class MailChimpCrawler
  def initialize
    @agent = Mechanize.new
  end

  def log_in
    page = @agent.get('https://login.mailchimp.com/') do |login_page|
      form = login_page.form_with(:name => nil)
      username_field = form.field_with(:name => "username")
      username_field.value = "blake41"
      password_field = form.field_with(:name => "password")
      password_field.value = "flatironschool1"
      @agent.page.form.submit
      logged_in = @agent.page.form.submit
    end
  end

  def download
    @agent.pluggable_parser.default = Mechanize::Download
    @agent.get('https://us5.admin.mailchimp.com/reports/export-all').save("main.csv")
  end

end

page = MailChimpCrawler.new
page.log_in
page.download