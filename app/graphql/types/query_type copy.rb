module Types
  class QueryType < BaseType
    field :investors, [Types::InvestorType], null: false do
      description "Get all investors"
    end

    field :investor, Types::InvestorType, null: true do
      argument :id, ID, required: true
      description "Get a specific investor by ID"
    end

    def investors
      Investor.all
    end

    def investor(id:)
      Investor.find_by(id: id)
    end
  end
end
