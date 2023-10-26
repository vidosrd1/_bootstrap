class Tag < ApplicationRecord
  has_many :children, :class_name => 'Tag', :foreign_key => 'parent_id'
  #attr_accessible :tag_name
  #default_scope { children }
  has_many :taggings, primary_key: :id,
  foreign_key: :tag_id,
  class_name: 'Tagging',
  :dependent => :destroy

  has_and_belongs_to_many :novines
  has_many :novines,
  :through => :taggings,
  #through: :taggings,
  source: :novine
end
