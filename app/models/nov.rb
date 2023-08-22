before_validation :check_for_newly_installed_template
def check_for_newly_installed_template
  if tagging_id.present?
    novine = Novine.find tagging_id
    if novine.present? and not novines.include?(novine)
      self.novines << novine
    end
  end
end

def self.tagged_with(name)
  Tag.find_by!(name: name).novines
end

def self.tag_counts
  Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
end

def tag_list
  tags.map(&:name).join(', ')
end

def tag_list=(names)
  self.tags = names.split(',').map do |n|
    Tag.where(name: n.strip).first_or_create!
  end
end
