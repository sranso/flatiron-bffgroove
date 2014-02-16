class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title, 
      t.string :subject, 
      t.string :list,
      t.datetime :send_date,
      t.string :send_weekday,
      t.integer :total_recipients,
      t.integer :successful_deliveries,
      t.integer :soft_bounces,
      t.integer :hard_bounces,
      t.integer :total_bounces,
      t.integer :times_forwarded,
      t.integer :forwarded_opens,
      t.integer :unique_opens,
      t.decimal :open_rate, scale: 2
      t.integer :total_opens,
      t.integer :unique_clicks, 
      t.decimal :click_rate, scale: 2
      t.integer :total_clicks, 
      t.integer :unsubscribes, 
      t.integer :abuse_complaints,
      t.integer :times_liked_on_facebook, 
      t.integer :folder_id,
      t.string :unique_id,
      t.decimal :analytics_ROI, scale: 2
      t.decimal :campaign_cost, scale: 2
      t.decimal :revenue_created, scale: 2
      t.integer :visits,
      t.integer :new_visits,  
      t.float :pages_visit,
      t.decimal :bounce_rate, scale: 2
      t.time :time_on_site, 
      t.decimal :goal_conversion_rate, scale: 2
      t.decimal :per_visit_goal_value, scale: 2
      t.integer :transactions,
      t.decimal :ecommerce_conversion_rate, scale: 2
      t.decimal :per_visit_value, scale: 2
      t.decimal :average_value, scale: 2
      t.timestamps
    end
  end
end
