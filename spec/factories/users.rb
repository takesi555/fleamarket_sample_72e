FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {"abc12345"}
    password_confirmation {"abc12345"}
    first_name            {"山田"}
    last_name             {"太郎"}
    first_name_kana       {"ヤマダ"}
    last_name_kana        {"タロウ"}
    birthday              {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end
