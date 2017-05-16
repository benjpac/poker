class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.column :name, :string
      t.column :money, :integer
    end

    create_table :hands do |t|
      t.column :deck_id, :integer
      t.column :player_id, :integer
      t.column :bet, :integer
    end

    create_table :cards do |t|
      t.column :round_id, :integer
      t.column :hand_id, :integer
      t.column :deck_id, :integer
      t.column :suit, :varchar
      t.column :value, :integer
    end

    create_table :rounds do |t|
      t.column :deck_id, :integer
      t.column :pot, :integer
    end

    create_table :decks
  end
end