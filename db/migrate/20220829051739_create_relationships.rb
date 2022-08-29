class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :pay_u, foreign_key: { to_table: :users }, index: true
      t.references :beneficiary_u,
                   foreign_key: {
                     to_table: :users
                   },
                   index: true
      t.timestamps
    end
  end
end
