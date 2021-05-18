FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    password {'test1234'}
    email { Faker::Internet.email }
    birth_date { Faker::Date.between_except(from: 20.year.ago, to: 1.year.from_now, excepted: Date.today) }
    first_name { '田中' }
    last_name { '太郎' }
    first_name_kana { 'タナカ' }
    last_name_kana { 'タロウ' }
  end
end