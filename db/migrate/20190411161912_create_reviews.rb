class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :product, foreign_key: true
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end
end
