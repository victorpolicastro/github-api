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

    OpenStruct.new(success?: true, data: user, message: "User #{email} successfully created")
  rescue StandardError => e
    Rails.logger.error("#{LOG_TAG} There was an error creating user with email #{email}")
    Rails.logger.error("#{LOG_TAG} #{e.message}")
    Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

    OpenStruct.new(success?: false, message: e.message)
  end

  private

  attr_accessor :email, :password
end
