class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]

  def index
    @campaigns = Campaign.order(:send_date).reverse.first(200)
    # @campaigns.to_values
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
      # format.csv {send_data @campaigns.to_csv}
      format.json {render "campaign/date.json.rabl"}
    end
  end

end