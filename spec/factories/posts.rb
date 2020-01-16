# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    picture { open('app/assets/images/suzu.jpg') }
    association :user
  end
end
