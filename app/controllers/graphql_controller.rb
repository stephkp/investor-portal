require_relative '../graphql/schema'

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    result = AppSchema.execute(params[:query], variables: ensure_hash(params[:variables]))
    render json: result
  rescue => e
    render json: { errors: [{ message: e.message }] }, status: :unprocessable_entity
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        JSON.parse(ambiguous_param)
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param.to_h
    else
      {}
    end
  rescue JSON::ParserError
    {}
  end
end
