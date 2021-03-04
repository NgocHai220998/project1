class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :sub_name
      t.string :body
      t.string :address
      t.string :building
      t.string :phone
      t.string :restroom_qty
      t.string :wifi
      t.string :base_id
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
