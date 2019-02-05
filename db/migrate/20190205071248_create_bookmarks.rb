class CreateBookmarks < ActiveRecord::Migration[5.2]
  def self.up
    create_table :bookmarks do |t|
      t.references :domain, foreign_key: true
      t.string :name
      t.string :metadata_title
      t.text :metadata_description
      t.text :url, null: false
      t.string :url_shortcut
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
