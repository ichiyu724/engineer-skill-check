class AddEmployeeidToArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :employee, null: false, foreign_key: true
  end
end
