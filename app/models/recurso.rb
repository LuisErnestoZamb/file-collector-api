class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero, :archivo, :procesado
end
