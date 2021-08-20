class CreateSpotEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :spot_equipments do |t|
      t.string :qty
      t.string :note
      t.string :name
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
