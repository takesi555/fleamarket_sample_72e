class AddDestinaitonIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :destination, foreign_key: true
  end
end
