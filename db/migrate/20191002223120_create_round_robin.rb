class CreateRoundRobin < ActiveRecord::Migration[5.2]
  def change
    create_table :round_robins do |t|
      t.string :startups_sa
      t.integer :startups_count
      t.string :growth_lse_sa
      t.integer :growth_lse_count
    end
  end
end
