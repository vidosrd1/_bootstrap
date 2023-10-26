module ApplicationHelper
  include Pagy::Frontend

  def subcat_prefix(depth)
    ("&nbsp;" * 4 * depth).html_safe
   end

   def category_options_array(current_id = 0,categories=[], parent_id=0, depth=0)
    Tag.where('parent_id = ? AND id != ?', parent_id, current_id ).order(:id).each do |tag|
      tags << [subcat_prefix(depth) + tag.name, tag.id]
      tag_options_array(current_id, tag, tag.id, depth+1)
    end

    tags
  end
end
