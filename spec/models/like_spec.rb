# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }

  it 'いいね,いいね取り消しができること' do
    expect { user.good(post) }.to change { user.liked_posts.count }.by(1)
    expect { user.not_good(post) }.to change { user.liked_posts.count }.by(-1)
  end
end
