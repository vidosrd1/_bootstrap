class Tagging < ApplicationRecord
  belongs_to :novine,
  primary_key: :id,
  foreign_key: :novine_id,
  class_name: 'Novine'

  belongs_to :tag,
  primary_key: :id,
  foreign_key: :tag_id,
  class_name: 'Tag'
end
