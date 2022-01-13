class AddKindToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :kind, :integer, default: 0
    add_index :posts, :kind
  end
end
