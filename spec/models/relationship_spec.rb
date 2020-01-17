# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:tester) { FactoryBot.create(:user) }
  let(:other_tester) { FactoryBot.create(:user) }
  
  it 'フォローするとfollowingが増えること、その取り消しができること' do
    expect { tester.follow(other_tester) }.to change { tester.following.count }.by(1)
    expect { tester.unfollow(other_tester) }.to change { tester.following.count }.by(-1)
  end
  
  it 'フォローされるとfollowersが増えること、その取り消しができること' do
    expect { other_tester.follow(tester) }.to change { tester.followers.count }.by(1)
    expect { other_tester.unfollow(tester) }.to change { tester.followers.count }.by(-1)
  end
end
