class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]

  def index
    @campaigns = Campaign.order(:send_date).reverse.first(200)
    respond_to do |format|
      format.html
      format.csv {send_data Campaign.to_csv}
      format.json {render "campaign/index.json.rabl"}
    end
  end
  
  def date
    @campaigns = Campaign.date_range(params[:from], params[:to])
    respond_to do |format|
      format.html
      format.csv {send_data @campaigns.to_csv}
      format.json {render "campaign/date.json.rabl"}
    end
  end

  def graph
    @weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @times = ["9AM - 10AM", "11AM - 12PM", "1PM - 2PM", "3PM - 4PM", "5PM - 6PM", "7PM - 8PM"]
    @yaxis = params[:yaxis]
    @sorted_campaigns = []
    @campaigns = Campaign.order(:send_date).reverse.first(120) # this isn't a certain number of days
    @campaigns.each do |campaign|
      @sorted_campaigns << campaign
    end

    respond_to do |format|
      format.html
      format.json { render "campaign/graph.json.rabl" }
    end
  end

end