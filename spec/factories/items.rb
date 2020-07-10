FactoryBot.define do
  factory :item do
    sequence(:id){|n| "#{n}"}
    sequence(:name){|n| "item#{n}"}
    sequence(:price) {|n| "#{n*1000}"}
    category_id{"1"}
    condition{"0"}
    size{""}
    preparation{"0"}
    postage{"0"}
    user_id{"1"}
    status{"1"}
    prefecture_id{"0"}
  end
end
