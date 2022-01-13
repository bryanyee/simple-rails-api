class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :text

      t.timestamps
    end

    add_reference :posts, :user
  end
end
