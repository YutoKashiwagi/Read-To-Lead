# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  let!(:comment) { FactoryBot.create(:comment, user: other_user, post: post) }

  it '有効なファクトリを持つこと' do
    expect(comment).to be_valid
  end
end
