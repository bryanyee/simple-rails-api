class AddQuoteToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :quote, :string
  end
end
