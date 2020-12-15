class Recurso < ApplicationRecord
  validates_presence_of :cnpnumero
  has_attached_file :carpeta
  validates_attachment_content_type :carpeta, :content_type => ["binary/octet-stream", "image/jpg", "image/jpeg", "image/png"]
end
