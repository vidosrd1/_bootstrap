class Novine < ApplicationRecord
  #@novines = Novine.joins(:taggings).
  #where(taggings: { tag_id: @ids })
  #attr_accessible :content, :heading, :image, :tag_ids, :tags, :tag_name, :tag_attributes
  validates :title, presence: true, uniqueness: true
  has_many :taggings,
  #primary_key: :id,
  #foreign_key: :novine_id,
  #class_name: 'Tagging',
  :dependent => :destroy

  #has_and_belongs_to_many :tags
  has_many :tags,
  :through => :taggings
  #through: :taggings,
  #source: :tag
  #accepts_nested_attributes_for :tags, :reject_if =>
  #proc { |attributes| attributes['tag_name'].blank? }
  #validates_presence_of :title, :name, :body
accepts_nested_attributes_for :taggings
  attr_writer :tag_names
  after_save :assign_tags
  #has_many :children_tags, -> { children },
  #  through: :taggings, source: :tag,
  #  class_name: "Tag"
  belongs_to :user
  has_one_attached :image
  has_many_attached :pictures
  has_rich_text :body
  #attr_accessor :tag_list
  attr_accessor :tagging_id

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    image.variant(resize_to_limit: [300, 300]).processed
  end
  def pictures_as_thumbnails
    pictures.map do |picture|
      picture.variant(resize_to_limit: [150, 150]).processed
    end
  end
  def pictures_as_thumbnails(article)
    article.variant(resize_to_limit: [200, 200]).processed
  end

  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
end
