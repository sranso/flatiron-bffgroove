class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:id)

    respond_to do |format|
      format.html
      format.json { render "group_campaign/index.json.rabl" }
    end
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render "group_campaign/show.json.rabl" }
    end
  end
  
  def search
    @search = GroupCampaign.search do 
      fulltext params[:search]
    end
    @group_campaigns = @search.results
  end  

end
