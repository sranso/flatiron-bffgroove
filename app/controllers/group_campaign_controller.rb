class GroupCampaignController < ApplicationController

  def index
    @group_campaigns = GroupCampaign.all
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])
  end 
end
