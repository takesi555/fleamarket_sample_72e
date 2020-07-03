class Prefectures < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :destinations,:prefectures
    remove_index :destinations,:prefecture_id
    remove_reference :destinations,:prefecture
    add_column :destinations,:prefecture_id,:integer,null: false

    remove_foreign_key :items,:prefectures
    remove_index :items,:prefecture_id
    remove_reference :items,:prefecture
    add_column :items,:prefecture_id,:integer,null: false
  end
end
