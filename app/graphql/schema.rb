require_relative 'types/base_type'
require_relative 'types/investor_type'
require_relative 'types/document_type'
require_relative 'types/query_type'
require_relative 'types/mutation_type'

class AppSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
