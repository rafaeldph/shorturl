class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.references :domain, null: false, foreign_key: true
      t.string :url
      t.string :short_code, limit: 5
      t.integer :visits

      t.timestamps
    end
    add_index :short_urls, :url, unique: true
    add_index :short_urls, :short_code, unique: true
  end
end
