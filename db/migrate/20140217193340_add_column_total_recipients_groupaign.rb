class AddColumnTotalRecipientsGroupaign < ActiveRecord::Migration
  def change
    add_column :groupaigns, :total_recipients, :integer
  end
end
