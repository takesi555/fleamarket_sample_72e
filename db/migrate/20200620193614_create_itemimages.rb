class CreateItemimages < ActiveRecord::Migration[5.2]
  def change
    create_table :itemimages do |t|
      t.references   :item,  type: :bigint,  null: false,  foreign_key:true
      t.string       :image,                 null: false
    end
  end
end