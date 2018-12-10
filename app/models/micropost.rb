class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length:
    {maximum: Settings.maximum_length_content}
  validate  :picture_size

  scope :sorted, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.size_picture.megabytes
    errors.add picture: t(".warning")
  end
end
