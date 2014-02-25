class ChangeColTypeForListsInCGc < ActiveRecord::Migration
  def up
    rename_column :campaigns, :list, :list_id
    change_column :campaigns, :list_id, :integer
    rename_column :group_campaigns, :list, :list_id
    change_column :group_campaigns, :list_id, :integer
  end

  def down
    rename_column :campaigns, :list_id, :list
    change_column :campaigns, :list, :string
    rename_column :group_campaigns, :list_id, :list
    change_column :group_campaigns, :list, :string
  end
end
