class DropAndReplaceHeaderColumns < ActiveRecord::Migration
  def change
    rename_column :campaigns, :analytics_ROI, :analytics_roi
    rename_column :campaigns, :pages_visit, :pagesvisit
    rename_column :group_campaigns, :analytics_ROI, :analytics_roi
    rename_column :group_campaigns, :pages_visit, :pagesvisit
  end

end
