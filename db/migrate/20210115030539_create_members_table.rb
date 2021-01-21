class CreateMembersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :team
      t.string :full_name
      t.string :first_name
      t.string :image
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
