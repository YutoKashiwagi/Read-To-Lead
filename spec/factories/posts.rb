# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title   { 'title' }
    picture { open('app/assets/images/suzu.jpg') }
    association :user
  end
end
