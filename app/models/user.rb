# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  # バリデーション
  validates :name,
            presence: true,
            length: { maximum: 30 }
  validates :email,     length: { maximum: 255 }
  validates :password,  length: { maximum: 30 }
  validates :profile,   length: { maximum: 200 }
  validates_acceptance_of :accepted
  # ユーザー機能
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  # フォロー周り(関係)
  has_many :active_relationships,  class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :following, through: 'active_relationships',  source: 'followed'
  has_many :followers, through: 'passive_relationships', source: 'follower'

  # いいね周り(関係)
  has_many :liked_posts, through: 'likes', source: 'post'

  # 通知周り(関係)
  has_many :active_notifications,   class_name: 'Notification',
                                    foreign_key: 'visitor_id',
                                    dependent: :destroy

  has_many :passive_notifications,  class_name: 'Notification',
                                    foreign_key: 'visited_id',
                                    dependent: :destroy

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )

    user
  end

  # フォロー周り（メソッド）
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # いいね周り（メソッド）
  def good(post)
    liked_posts << post
  end

  def not_good(post)
    likes.find_by(post_id: post.id).destroy
  end

  def good?(post)
    liked_posts.include?(post)
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
