# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    picture { 'MyString' }
    user { nil }
  end
end
