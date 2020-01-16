# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:tester_for_like) { FactoryBot.create(:user) }
  let(:post_for_like) { FactoryBot.create(:post, user: tester_for_like) }

  it 'いいね,いいね取り消しができること' do
    expect { tester_for_like.good(post_for_like) }.to change { tester_for_like.liked_posts.count }.by(1)
    expect { tester_for_like.not_good(post_for_like) }.to change { tester_for_like.liked_posts.count }.by(-1)
  end
end
