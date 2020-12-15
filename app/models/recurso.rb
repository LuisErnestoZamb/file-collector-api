class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero
  validates :carpeta, attachment_presence: true
end
