class CreateCreditcards < ActiveRecord::Migration[5.2]
  def change
    create_table :creditcards do |t|
      t.references  :user,   type: :bigint,   null: false, foreign_key:true
      t.string      :payjp_custumer_id,       null: false
      t.string      :payjp_card_id,           null: false
    end
  end
end
