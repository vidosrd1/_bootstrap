class BlogPost < ApplicationRecord
  after_update_commit { broadcast_append_to 'todos' }
  validates :title, presence: true
  validates :body, presence: true
  has_rich_text :body
  #scope :sorted,
  #->{ order(arel_table(:published_at).desc.nulls_first)
  #  .order(update_at: :desc)}
  enum status: { incomplete: 0, complete: 1 }
end
