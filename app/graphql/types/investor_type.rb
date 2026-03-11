module Types
  class InvestorType < BaseType
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :date_of_birth, GraphQL::Types::ISO8601Date, null: false
    field :phone_number, String, null: false
    field :street_address, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip_code, String, null: false
    field :ssn, String, null: false
    field :documents_attached, Boolean, null: false
    field :documents, [Types::DocumentType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def documents_attached
      object.documents.attached?
    end

    def documents
      object.documents.map do |doc|
        {
          id: doc.id,
          filename: doc.filename.to_s,
          byte_size: doc.byte_size,
          download_url: Rails.application.routes.url_helpers.rails_blob_url(doc, only_path: true)
        }
      end
    end
  end
end