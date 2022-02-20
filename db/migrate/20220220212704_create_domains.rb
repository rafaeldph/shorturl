class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains do |t|
      t.string :url
      t.string :alexa_rank

      t.timestamps
    end
    add_index :domains, :url, unique: true
  end
end
