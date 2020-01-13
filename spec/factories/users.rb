# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name     {'tester'}
    email    {'tester@tester.com'}
    password {'password'}
  end
end
