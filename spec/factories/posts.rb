# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    picture { open('app/assets/images/suzu.jpg') }
    user_id {FactoryBot.create(:user).id}
  end
end
