class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero, :archivo
end
