class CreateBiblios < ActiveRecord::Migration
  def self.up
    create_table :biblios do |t|
      t.integer :notice_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :biblios
  end
end
