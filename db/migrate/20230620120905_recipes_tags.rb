class RecipesTags < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_tags, id: false do |t|
      t.integer :recipe_id
      t.uuid :tag_id
    end
  end
end
