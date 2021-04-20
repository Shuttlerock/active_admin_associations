class CreateTaggings < ActiveRecord::Migration[4.2]
  def change
    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.string :taggable_type, null: false
      t.integer :taggable_id, null: false
      t.timestamps
    end
  end
end
