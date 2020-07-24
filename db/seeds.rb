# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('db/brands.csv',headers: true) do |row|
  if Brand.where(name: row['name']).blank? then
    Brand.create(
      name: row['name'],
    )
  end
end 

CSV.foreach('db/categories.csv',headers: true) do |row|
  if Category.where(name: row['name']).blank? then
    Category.create(
      name:     row['name'],
      ancestry: row['ancestry']
    )
  end
end 

CSV.foreach('db/items.csv',headers: true) do |row|
  if Item.where(created_at: row['created_at']).blank? then
    Item.create(
      id:             row['id'],
      name:           row['name'],
      price:          row['price'],
      description:    row['description'],
      closed_time:    row['closed_time'],
      buyer_id:       row['buyer_id'],
      prefecture_id:  row['prefecture_id'],
      category_id:    row['category_id'],
      brand_id:       row['brand_id'],
      size:           row['size'],
      condition_id:      row['condition_id'],
      preparation_id:    row['preparation_id'],
      postage_id:        row['postage_id'],
      user_id:        row['user_id'],
      status:         row['status'],
      created_at:     row['created_at'],
      updated_at:     row['updated_at'],
      destination_id: row['destination_id']
    )
  end
end 

CSV.foreach('db/itemimages.csv',headers: true) do |row|
  if Itemimage.where(image: row['image'],item_id: row['item_id']).blank? then
    Itemimage.create(
      id:       row['id'],
      item_id:  row['item_id'],
      image:    row['image']
    )
  end
end 

CSV.foreach('db/prefectures.csv',headers: true) do |row|
  if Prefecture.where(name: row['name']).blank? then
    Prefecture.create(
      id: row['id'],
      name: row['name'],
    )
  end
end 
