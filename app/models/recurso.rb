class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero
  has_attached_file :carpeta
end
