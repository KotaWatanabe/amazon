class CreateNewsArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :description
      t.timestamp :published_at, default: nil
      t.bigint :view_count

      t.timestamps
    end
  end
end
