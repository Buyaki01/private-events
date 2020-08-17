class AddCreatorIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :creator, foreign_key: { to_table: :users } 
  end
end
