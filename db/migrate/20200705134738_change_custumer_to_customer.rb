class ChangeCustumerToCustomer < ActiveRecord::Migration[5.2]
  def change
    rename_column :Creditcards,:payjp_custumer_id,:payjp_customer_id
  end
end
