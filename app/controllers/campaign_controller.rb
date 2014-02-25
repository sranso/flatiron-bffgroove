class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]

  def index
    @campaigns = Campaign.order(:id).first(200)
    # @campaigns.to_values
    respond_to do |format|
      format.html
      format.csv { send_data Campaign.to_csv}
      format.json {render "campaign/index.json.rabl"}
    end
  end

  def report
    @report = Campaign.report do 
      fulltext params[:from], params[:to]
    end
    @campaigns = @report.results
    @datecampaigns = Campaign.date_range(DateTime.params[:from].utc, DateTime.params[:to].utc)
  end  

  def self.date_range(from,to)
    @date_results = Campaign.find(:all, :conditions => [ "BETWEEN ? AND ?", from, to])
  end

end
