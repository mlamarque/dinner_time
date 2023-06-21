class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.string :quantity
      t.uuid :food_id, null: false
      t.uuid :recipe_id, null: false
      t.timestamps
    end
    add_index(:ingredients, [:food_id, :recipe_id], unique: true)
  end
end
