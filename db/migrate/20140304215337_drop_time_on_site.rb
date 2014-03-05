class DropTimeOnSite < ActiveRecord::Migration
  def up
    remove_column :campaigns, :time_on_site
  end

  def down
    add_column :campaigns, :time_on_site, :time
  end
end
