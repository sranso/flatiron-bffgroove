class CampaignController < ApplicationController
  def index
    @campaigns = Campaign.all  
  end
end
