class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

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
