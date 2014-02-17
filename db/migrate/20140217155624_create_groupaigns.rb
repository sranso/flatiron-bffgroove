class CreateGroupaigns < ActiveRecord::Migration
  def change
    create_table :groupaigns do |t|
      t.string :title
      t.timestamps
    end
  end
end
