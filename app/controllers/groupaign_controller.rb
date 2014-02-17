class GroupaignController < ApplicationController

  def index
    @groupaigns = Groupaign.all
  end 

  def show
    @groupaign = Groupaign.find(params[:id])
  end 
end
