class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string       :name,                        null: false
      t.integer      :price,                       null: false
      t.text         :description
      t.timestamp    :closed_time
      t.bigint       :buyer_id
      t.references   :prefecture,  type: :bigint,  null: false,  foreign_key:true
      t.references   :category,    type: :bigint,  null: false,  foreign_key:true
      t.references   :brand,       type: :bigint,  null: false,  foreign_key:true
      t.string       :size,                        null: false
      t.integer      :condition,                   null: false
      t.integer      :preparation,                 null: false
      t.integer      :postage,                     null: false
      t.references   :user,        type: :bigint,  null: false,  foreign_key:true
      t.integer      :status,                      null: false
      t.timestamps
    end
  end
end