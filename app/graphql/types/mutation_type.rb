module Types
  class MutationType < BaseType
    field :create_investor, Types::InvestorType, null: true do
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :date_of_birth, GraphQL::Types::ISO8601Date, required: true
      argument :phone_number, String, required: true
      argument :street_address, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip_code, String, required: true
      argument :ssn, String, required: true
      argument :documents, [GraphQL::Types::String], required: false
      description "Create a new investor"
    end

    field :update_investor, Types::InvestorType, null: true do
      argument :id, ID, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :date_of_birth, GraphQL::Types::ISO8601Date, required: false
      argument :phone_number, String, required: false
      argument :street_address, String, required: false
      argument :city, String, required: false
      argument :state, String, required: false
      argument :zip_code, String, required: false
      argument :ssn, String, required: false
      description "Update an existing investor"
    end

    def create_investor(**args)
      investor = Investor.new(args.except(:documents))
      
      if investor.save
        # Handle document attachments if provided
        if args[:documents].present?
          args[:documents].each do |document_data|
            # This would need to be implemented based on how you handle file uploads
            # For now, we'll skip document attachment in GraphQL
          end
        end
        investor
      else
        raise GraphQL::ExecutionError, investor.errors.full_messages.join(", ")
      end
    end

    def update_investor(id:, **args)
      investor = Investor.find_by(id: id)
      return nil unless investor

      if investor.update(args)
        investor
      else
        raise GraphQL::ExecutionError, investor.errors.full_messages.join(", ")
      end
    end
  end
end
