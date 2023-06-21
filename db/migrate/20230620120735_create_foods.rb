class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index(:foods, :name)
  end
end
