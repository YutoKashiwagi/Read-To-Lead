# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  let!(:comment) { FactoryBot.create(:comment, user: user, post: post) }

  it '有効なファクトリを持つこと' do
    expect(user).to be_valid
    expect(post).to be_valid
    expect(post.user).to eq user
    expect(other_user).to be_valid
  end

  context 'いいねの通知' do
    it '正常な通知が作成されること' do
      # other_user.good(post)
      expect { post.create_notification_like(other_user) }.to change { user.passive_notifications.count }.by(1)
      notification = Notification.first
      # 中身の確認
      expect(notification.visitor).to eq other_user
      expect(notification.visited).to eq user
      expect(notification.action).to  eq 'like'
    end
  end

  context 'フォローの通知' do
    it '正常な通知が作成されること' do
      # other_user.follow(user)
      expect { user.create_notification_follow(other_user) }.to change { user.passive_notifications.count }.by(1)
      notification = Notification.first
      # 中身の確認
      expect(notification.visitor).to eq other_user
      expect(notification.visited).to eq user
      expect(notification.action).to  eq 'follow'
    end
  end
  context 'コメントの通知' do
    it '正常な通知が作成されること' do
      expect { post.create_notification_comment(other_user, comment.id) }.to change { user.passive_notifications.count }.by(1)
    end
  end
end
