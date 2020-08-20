# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create

      # POST /api/v1/users
      def create
        response = CreateUserService.new(user_params[:email], user_params[:password]).call

        return(render(json: { errors: response.message }, status: :unprocessable_entity)) unless response.success?

        render(json: { message: response.message })
      end

      private

      def user_params
        params.permit(
          :email, :password
        )
      end
    end
  end
end
