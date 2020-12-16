class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero
  has_attached_file :carpeta
  do_not_validate_attachment_file_type :carpeta, :s3_permissions => {
    :original => :private
  }
end
