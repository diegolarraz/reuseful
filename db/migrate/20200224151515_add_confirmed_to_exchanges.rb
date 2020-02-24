class AddConfirmedToExchanges < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :confirmed, :boolean, default: false
  end
end
