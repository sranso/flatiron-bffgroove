class CampaignController < ApplicationController
  def index
    @campaigns = Campaign.first(200)  
  end
end
