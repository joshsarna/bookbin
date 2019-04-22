class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :worth_reading

      t.timestamps
    end
  end
end
