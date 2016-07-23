class RemovePendingApprovalFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :pending_approval, :boolean
  end
end
