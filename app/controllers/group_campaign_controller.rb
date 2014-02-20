class GroupCampaignController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group_campaigns = GroupCampaign.order(:id)

    respond_to do |format|
      format.html
      format.json { render json: @group_campaigns }
    end

  end 

  def show
    @group_campaign = GroupCampaign.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @group_campaign, :methods => :campaigns }
    end
  end 
end
