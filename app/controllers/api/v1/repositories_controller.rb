# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      before_action :authorize_request

      # GET /api/v1/repositories
      def index
        response = Github::SearchRepositoriesService.new(search_params).call
        return(render(json: { errors: response.message }, status: :unprocessable_entity)) unless response.success?

        payload = response.data.deep_symbolize_keys
        data = ::Api::V1::Repositories::IndexPresenter.new(payload[:items]).attributes

        render(json: { data: data })
      end

      private

      def search_params
        params.permit(:repository_name, :language, :user, :sort, :order, :page, :per_page)
      end
    end
  end
end
