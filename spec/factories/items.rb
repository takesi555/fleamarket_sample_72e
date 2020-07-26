FactoryBot.define do
  factory :item do
    name            {"Tシャツ"}
    description     {"限定品です"}
    category        {FactoryBot.create(:category)}
    size            {"1"}
    brand           {FactoryBot.create(:brand)}
    condition_id    {1}
    postage_id      {1}
    prefecture      {FactoryBot.create(:prefecture)}
    preparation_id  {1}
    price           {1000}
    user            {FactoryBot.create(:user)}
    status          {1}

    after(:build) do |item|
      item.itemimages << FactoryBot.build(:itemimage, item: item)
    end
  end
end
