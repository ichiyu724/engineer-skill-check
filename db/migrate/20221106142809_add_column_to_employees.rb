class AddColumnToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :news_post_auth, :boolean, default: false, null: false
  end
end
