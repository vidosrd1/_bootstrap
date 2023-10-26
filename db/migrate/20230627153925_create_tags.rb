class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :parent_id, default: 0

      t.timestamps
    end
  end
end
