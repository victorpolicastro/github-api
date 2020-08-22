# frozen_string_literal: true

module Github
  class SearchRepositoriesService
    LOG_TAG = '[SEARCH REPOSITORIES]:'
    private_constant :LOG_TAG
    ENDPOINT = 'https://api.github.com/search/repositories'
    private_constant :ENDPOINT
    METHOD = 'GET'
    private_constant :METHOD

    def initialize(params = {})
      @params = params
    end

    def call
      SendRequestService.new(METHOD, ENDPOINT, options).call
    rescue StandardError => e
      Rails.logger.error("#{LOG_TAG} #{e.message}")
      Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

      Response.new(success?: false, message: e.message)
    end

    private

    attr_reader :params

    def options
      search_term =
        if params[:repository_name]
          params[:repository_name]
        elsif params[:language]
          "language:#{params[:language]}"
        elsif params[:user]
          "user:#{params[:user]}"
        else
          'language:ruby'
        end

      {
        q: search_term,
        sort: params[:sort],
        order: params[:order],
        page: params[:page],
        per_page: params[:per_page]
      }
    end
  end
end
