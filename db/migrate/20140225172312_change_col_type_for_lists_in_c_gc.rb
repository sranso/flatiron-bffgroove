class ChangeColTypeForListsInCGc < ActiveRecord::Migration
  def up
    change_column :campaigns, :list, :integer
    change_column :group_campaigns, :list, :integer
  end

  def down
    change_column :campaigns, :list, :string
    change_column :group_campaigns, :list, :string
  end
end
