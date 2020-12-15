class AddAttachmentCarpetaToRecursos < ActiveRecord::Migration[4.2]
  def self.up
    change_table :recursos do |t|
      t.attachment :carpeta
    end
  end

  def self.down
    remove_attachment :recursos, :carpeta
  end
end
