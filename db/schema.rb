# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140217213530) do

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "subject"
    t.string   "list"
    t.datetime "send_date"
    t.string   "send_weekday"
    t.integer  "total_recipients"
    t.integer  "successful_deliveries"
    t.integer  "soft_bounces"
    t.integer  "hard_bounces"
    t.integer  "total_bounces"
    t.integer  "times_forwarded"
    t.integer  "forwarded_opens"
    t.integer  "unique_opens"
    t.decimal  "open_rate"
    t.integer  "total_opens"
    t.integer  "unique_clicks"
    t.decimal  "click_rate"
    t.integer  "total_clicks"
    t.integer  "unsubscribes"
    t.integer  "abuse_complaints"
    t.integer  "times_liked_on_facebook"
    t.integer  "folder_id"
    t.string   "unique_id"
    t.decimal  "analytics_ROI"
    t.decimal  "campaign_cost"
    t.decimal  "revenue_created"
    t.integer  "visits"
    t.integer  "new_visits"
    t.float    "pages_visit"
    t.decimal  "bounce_rate"
    t.time     "time_on_site"
    t.decimal  "goal_conversion_rate"
    t.decimal  "per_visit_goal_value"
    t.integer  "transactions"
    t.decimal  "ecommerce_conversion_rate"
    t.decimal  "per_visit_value"
    t.decimal  "average_value"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "groupaign_id"
  end

  create_table "groupaigns", :force => true do |t|
    t.string   "title"
    t.string   "subject"
    t.string   "list"
    t.datetime "send_date"
    t.string   "send_weekday"
    t.integer  "total_recipients"
    t.integer  "successful_deliveries"
    t.integer  "soft_bounces"
    t.integer  "hard_bounces"
    t.integer  "total_bounces"
    t.integer  "times_forwarded"
    t.integer  "forwarded_opens"
    t.integer  "unique_opens"
    t.decimal  "open_rate"
    t.integer  "total_opens"
    t.integer  "unique_clicks"
    t.decimal  "click_rate"
    t.integer  "total_clicks"
    t.integer  "unsubscribes"
    t.integer  "abuse_complaints"
    t.integer  "times_liked_on_facebook"
    t.integer  "folder_id"
    t.string   "unique_id"
    t.decimal  "analytics_ROI"
    t.decimal  "campaign_cost"
    t.decimal  "revenue_created"
    t.integer  "visits"
    t.integer  "new_visits"
    t.float    "pages_visit"
    t.decimal  "bounce_rate"
    t.time     "time_on_site"
    t.decimal  "goal_conversion_rate"
    t.decimal  "per_visit_goal_value"
    t.integer  "transactions"
    t.decimal  "ecommerce_conversion_rate"
    t.decimal  "per_visit_value"
    t.decimal  "average_value"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
