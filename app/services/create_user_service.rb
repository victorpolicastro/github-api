# frozen_string_literal: true

class CreateUserService
  include ActiveModel::Validations

  LOG_TAG = '[USER CREATION]:'
  private_constant :LOG_TAG

  validates :email, :password, presence: true

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    raise_validation_error if invalid?

    user = User.create!(email: email, password: password)

    Response.new(success?: true, data: user, message: "User #{email} successfully created")
  rescue StandardError => e
    Rails.logger.error("#{LOG_TAG} #{e.message}")
    Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

    Response.new(success?: false, message: e.message)
  end

  private

  attr_accessor :email, :password
end
