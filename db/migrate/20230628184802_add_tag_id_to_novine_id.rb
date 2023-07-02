class AddTagIdToNovineId < ActiveRecord::Migration[7.0]
  def change
    add_column :tag_id, :integer
    add_column :novine_id, :integer
  end
end
