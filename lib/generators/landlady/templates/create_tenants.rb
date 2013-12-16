class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :subdomain
      t.string :name
      t.string :description
      t.string :code
      t.string :locale

      t.timestamps
    end
  end
end
