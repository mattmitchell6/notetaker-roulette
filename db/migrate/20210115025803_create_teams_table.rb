class CreateTeamsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      # has_many :members
      t.string :name
      t.string :url, unique: true
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
