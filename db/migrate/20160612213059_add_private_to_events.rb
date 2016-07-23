class AddPrivateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :private, :boolean, default: 0
  end
end
