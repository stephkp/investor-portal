module Types
  class DocumentType < BaseType
    field :id, ID, null: false
    field :filename, String, null: false
    field :byte_size, Integer, null: false
    field :download_url, String, null: false
  end
end
