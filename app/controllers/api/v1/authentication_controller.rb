# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_request, except: :login

      # POST /api/v1/auth/login
      def login
        response = AuthenticateUserService.new(login_params[:email], login_params[:password]).call

        return(render(json: { errors: response.message }, status: :unauthorized)) unless response.success?

        render(json: { message: response.data })
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
