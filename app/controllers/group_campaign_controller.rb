class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:id)
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])
  end 
end
