class CreateRecursos < ActiveRecord::Migration[6.0]
  def change
    create_table :recursos do |t|
      t.integer :cnpnumero
      t.binary :archivo
      t.boolean :procesado

      t.timestamps
    end
  end
end
