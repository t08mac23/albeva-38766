FactoryBot.define do
  factory :drink do
    name                {Faker::Lorem.sentence}
    description         {Faker::Lorem.sentence}
    alc_percent         {Faker::Number.between(from: 0, to: 100)}
    combo               {Faker::Lorem.sentence}
    genre_id            {Faker::Number.between(from: 2, to: 11)}
    sweet_dry_id        {Faker::Number.between(from: 2, to: 6)}
    recommendation_id   {Faker::Number.between(from: 2, to: 6)}
    best_time_id        {Faker::Number.between(from: 2, to: 11)}
    
    association :user

    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/f569f9fd1992c36a6c42c915abbd924c_w.jpeg'))}
  end
end
