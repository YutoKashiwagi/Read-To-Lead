class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :comment, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size

  private

    def picture_size
      if picture.size > 100.megabytes
        errors.add(:picture, "should be less than 100MB")
      end
    end
end
