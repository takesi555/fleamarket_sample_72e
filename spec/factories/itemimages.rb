FactoryBot.define do
  factory :itemimage do
    image     { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.png")) }
  end
end
