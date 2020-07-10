FactoryBot.define do
  factory :user do
    sequence(:id){|n| "#{n}"}
    sequence(:nickname){|n| "User#{n}"}
    sequence(:email) {|n| "testeer#{n}@example.com"}
    first_name{"a"}
    last_name{"a"}
    first_name_kana{"a"}
    last_name_kana{"a"}
    tel{"00000000000"}
    birth{"2020/02/02"}
  end
end
