class RemoveAuthorFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :author, :integer, null: false
  end
end