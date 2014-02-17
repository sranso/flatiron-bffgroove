class AddGroupaignIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :groupaign_id, :integer
  end
end
