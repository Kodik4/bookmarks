class CreateDomains < ActiveRecord::Migration[5.2]
  def self.up
    create_table :domains do |t|
      t.string :name, null: false
    end

    add_index :domains, :name, unique: true
  end

  def self.down
    drop_table :domains
  end
end
