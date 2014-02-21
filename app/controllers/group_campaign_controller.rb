class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:id)

    respond_to do |format|
      format.html
<<<<<<< HEAD
      format.csv { send_data GroupCampaign.to_csv }
=======
>>>>>>> f20bc7c5b8f3e128990137f62c2a31c73132621d
      format.json { render "group_campaign/index.json.rabl" }
    end
  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])

    respond_to do |format|
      format.html
<<<<<<< HEAD
      format.csv { send_data @group_campaign.to_csv }
=======
>>>>>>> f20bc7c5b8f3e128990137f62c2a31c73132621d
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
