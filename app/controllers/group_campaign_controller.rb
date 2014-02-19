class GroupCampaignController < ApplicationController

  def index
    @group_campaigns = GroupCampaign.all
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])
  end
  

  def search
    @group_campaigns = GroupCampaign.search_engine(params[:search])
  end  


end
