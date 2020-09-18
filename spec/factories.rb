FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    website { "http://www.example.com" }
  end

  factory :heading do
    name { Faker::Game.title }
  end
end
