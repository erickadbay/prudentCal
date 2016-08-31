class AddCreatorToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator, :string
  end
end
