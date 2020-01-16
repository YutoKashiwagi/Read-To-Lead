# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:tester_for_follow) { FactoryBot.create(:user) }
  let(:other_tester_for_follow) { FactoryBot.create(:user) }
  it 'フォローするとfollowingが増えること、その取り消しができること' do
    expect { tester_for_follow.follow(other_tester_for_follow) }.to change { tester_for_follow.following.count }.by(1)
    expect { tester_for_follow.unfollow(other_tester_for_follow) }.to change { tester_for_follow.following.count }.by(-1)
  end
  
  it 'フォローされるとfollowersが増えること、その取り消しができること' do
    expect { other_tester_for_follow.follow(tester_for_follow) }.to change { tester_for_follow.followers.count }.by(1)
    expect { other_tester_for_follow.unfollow(tester_for_follow) }.to change { tester_for_follow.followers.count }.by(-1)
  end
end
