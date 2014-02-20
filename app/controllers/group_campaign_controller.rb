class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:id)
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])
  end
  
  def search
    @search = GroupCampaign.search do 
      fulltext params[:search]
    end
    @group_campaigns = @search.results
  end  


end
