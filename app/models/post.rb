# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user

  has_many :comment,       dependent: :destroy
  has_many :likes,         dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :liked_users, through: 'likes', source: 'user'

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size

  # いいねされたときに通知を送る
  def create_notification_like(current_user)
    # すでにいいねされているかのチェック。いいねを連打されても通知は最初の一回しか来ない
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ?', current_user.id, user_id, id, 'like'])

    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分で自分の投稿にいいねした場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  # コメントされたときに通知を送る
  def create_notification_comment(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントの場合は複数回通知が来るようにする
    # notification = Notification.new(
    #   post_id: id,
    #   comment_id: comment_id,
    #   visited_id: current_user.id,
    #   action: 'comment'
    # )
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿にコメントした場合、通知済みとする
    # notification.checked = true if notification.visited_id == notification.visitor_id
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  private

  def picture_size
    errors.add(:picture, 'should be less than 100MB') if picture.size > 100.megabytes
  end
end
