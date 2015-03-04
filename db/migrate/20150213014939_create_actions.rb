class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :action_id, :null => false
      t.boolean :read_state, :null => false, :default => false

      t.timestamps
    end
    add_index :actions, :action_id
  end
end
