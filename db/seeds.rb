require 'csv'

CSV.foreach('db/prefectures.csv',headers: true) do |row|
 Prefecture.create(
   name: row['name'],
 )

end
