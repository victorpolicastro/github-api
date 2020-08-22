# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class IndexPresenter
        def initialize(repositories)
          @repositories = repositories
        end

        def attributes
          repositories.map do |repository|
            {
              full_name: repository[:full_name],
              description: repository[:description],
              stars: repository[:stargazers_count],
              forks: repository[:forks],
              owner: repository[:owner][:login]
            }
          end
        end

        private

        attr_reader :repositories, :page, :per_page
      end
    end
  end
end
