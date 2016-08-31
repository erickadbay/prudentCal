class FixPendingApprovalColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :pending_approval, :pending_decision
  end
end
