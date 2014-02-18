class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  def index
    @campaigns = Campaign.first(200)  
  end
end
