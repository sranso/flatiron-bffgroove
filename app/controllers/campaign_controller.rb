class CampaignController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]

  def index
    @campaigns = Campaign.order(:id).first(200)
  end
end
