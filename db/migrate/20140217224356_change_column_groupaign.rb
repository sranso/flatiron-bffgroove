class ChangeColumnGroupaign < ActiveRecord::Migration
  def change
    rename_column :campaigns, :groupaign_id, :group_campaign_id
  end
end
