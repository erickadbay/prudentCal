class AddReferencesToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :course, index: true, foreign_key: true
  end
end
