class AddPendingApprovalToEvents < ActiveRecord::Migration
  def change
    add_column :events, :pending_approval, :boolean, default: true
  end
end
