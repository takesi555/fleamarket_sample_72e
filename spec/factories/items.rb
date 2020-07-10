FactoryBot.define do
  factory :item ,class: Item do
    sequence(:id){|n| "#{n}"}
    sequence(:name){|n| "item#{n}"}
    sequence(:price) {|n| "#{n*1000}"}
    category_id{"1"}
    condition{"0"}
    size{"a"}
    preparation{"0"}
    postage{"0"}
    user_id{"1"}
    status{"1"}
    prefecture_id{"1"}
    
  end
end
