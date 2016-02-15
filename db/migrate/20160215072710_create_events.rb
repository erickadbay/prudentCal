class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :event_date
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
