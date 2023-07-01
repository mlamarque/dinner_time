class AddSlugToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :slug, :string

    Recipe.find_each.each do |r|
      r.update(slug: r.name.parameterize)
    end
  end
end
