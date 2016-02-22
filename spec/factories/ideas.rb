# == Schema Information
#
# Table name: ideas
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :idea do
    title {Faker::Company.bs}
    body {Faker::Lorem.paragraph}
    association :user,     factory: :user
  end
end
