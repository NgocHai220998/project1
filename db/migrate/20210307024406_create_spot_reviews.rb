class CreateSpotReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :spot_reviews do |t|
      t.integer :user_id
      t.datetime :posted_at
      t.string :comment
      t.integer :view_count
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
