class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :event_id
      t.text :notes
      t.belongs_to :user

      t.timestamps
    end
  end
end
