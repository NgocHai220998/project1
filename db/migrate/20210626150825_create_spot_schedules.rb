class CreateSpotSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :spot_schedules do |t|
      t.integer :kind
      t.integer :season
      t.datetime :start_on
      t.datetime :end_on
      t.string :day_of_week
      t.string :hour
      t.string :note
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
