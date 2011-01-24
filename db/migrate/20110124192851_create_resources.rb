class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :technicalRequirements
      t.string :url
      t.string :title
      t.string :format
      t.references :notice

      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
