class AddCampaignColsToGroupaign < ActiveRecord::Migration
  def change
    add_column :groupaigns, :successful_deliveries, :integer
    add_column :groupaigns, :soft_bounces, :integer
    add_column :groupaigns, :hard_bounces, :integer
    add_column :groupaigns, :total_bounces, :integer
    add_column :groupaigns, :times_forwarded, :integer
    add_column :groupaigns, :forwarded_opens, :integer
    add_column :groupaigns, :unique_opens, :integer
    add_column :groupaigns, :total_opens, :integer
    add_column :groupaigns, :unique_clicks, :integer
    add_column :groupaigns, :total_clicks, :integer
    add_column :groupaigns, :unsubscribes, :integer
    add_column :groupaigns, :abuse_complaints, :integer
    add_column :groupaigns, :times_liked_on_facebook, :integer
    add_column :groupaigns, :folder_id, :integer
    add_column :groupaigns, :visits, :integer
    add_column :groupaigns, :new_visits, :integer
    add_column :groupaigns, :transactions, :integer
  end
end
