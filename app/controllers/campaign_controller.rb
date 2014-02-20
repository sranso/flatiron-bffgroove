class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]

  def index
    @campaigns = Campaign.order(:id).first(200)
    respond_to do |format|
      format.html
      format.json {render "campaign/index.json.rabl"}
    end
  end
end
