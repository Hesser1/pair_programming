class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.timestamp :released_at
      t.references :user, index: true
      t.references :movie, index: true

      t.timestamps
    end
  end
end
