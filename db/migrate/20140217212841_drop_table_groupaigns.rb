class DropTableGroupaigns < ActiveRecord::Migration
  def up
    drop_table :groupaigns
  end

  def down
    create_table :groupaigns do |t|
      t.string  :title
      t.integer :total_recipients
      t.integer :successful_deliveries
      t.integer :soft_bounces
      t.integer :hard_bounces
      t.integer :total_bounces
      t.integer :times_forwarded
      t.integer :forwarded_opens
      t.integer :unique_opens
      t.integer :total_opens
      t.integer :unique_clicks 
      t.integer :total_clicks 
      t.integer :unsubscribes 
      t.integer :abuse_complaints
      t.integer :times_liked_on_facebook 
      t.integer :folder_id
      t.integer :visits
      t.integer :new_visits  
      t.integer :transactions
      t.timestamps
    end
  end
end
