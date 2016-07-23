class AddClassNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :className, :string
  end
end
