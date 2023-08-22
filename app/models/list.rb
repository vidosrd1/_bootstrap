class List < ApplicationRecord
  #after_update_commit { broadcast_append_to 'lists' }
  belongs_to :art
  has_one_attached :image
  has_rich_text :body
  #enum status: { incomplete: 0, complete: 1 }

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
