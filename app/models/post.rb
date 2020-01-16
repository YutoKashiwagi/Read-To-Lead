# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user

  has_many :comment, dependent: :destroy
  has_many :likes,   dependent: :destroy

  has_many :liked_users, through: 'likes', source: 'user'

  default_scope -> { order(created_at: :desc) }
  # mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size

  private

  def picture_size
    errors.add(:picture, 'should be less than 100MB') if picture.size > 100.megabytes
  end
end
