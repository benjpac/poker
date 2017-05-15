class NewTables < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.column :name, :string
      t.column :money, :integer
    end

    create_table :hands do |t|
      t.column :player_id, :integer
      t.column :bet_total, :integer
    end

    create_table :cards do |t|
      t.column :flop_id, :integer
      t.column :hand_id, :integer
      t.column :suit, :varchar
      t.column :value, :integer
    end

    create_table :flops do |t|
      t.column :total_bets, :integer
    end
  end
end
