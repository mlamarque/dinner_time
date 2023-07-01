# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :difficulty, default: 0
      t.integer :prep_time, null: false
      t.integer :cook_time, null: false
      t.float :rate
      t.string :author, null: false
      t.string :image, null: false

      t.timestamps
    end

    add_index(:recipes, :name)
  end
end
