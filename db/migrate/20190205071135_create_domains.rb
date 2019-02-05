class CreateDomains < ActiveRecord::Migration[5.2]
  def self.up
    create_table :domains do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :domains
  end
end
