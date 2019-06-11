FactoryBot.define do
  factory :tweet do
    text        {"hello!"}
    image       {"hoge.png"}
    # created_atがランダムに生成
    created_at  {Faker::Time.between(2.days.ago, Time.now, :all)}
    user
  end
end