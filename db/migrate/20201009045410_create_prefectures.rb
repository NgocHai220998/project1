class CreatePrefectures < ActiveRecord::Migration[6.0]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.string :name_spoken

      t.timestamps
    end
  end
end
