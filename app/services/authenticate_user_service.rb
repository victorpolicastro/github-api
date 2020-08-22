# frozen_string_literal: true

class AuthenticateUserService
  include ActiveModel::Validations

  LOG_TAG = '[AUTHENTICATE USER]:'
  private_constant :LOG_TAG

  validates :email, :password, :user, presence: true

  def initialize(email, password)
    @email = email
    @password = password
    @user = User.find_by(email: email)
  end

  def call
    raise_validation_error if invalid?

    unless user.authenticate(password)
      return Response.new(success?: false, message: 'There was an error in your authentication')
    end

    token, time = create_token

    Response.new(success?: true, data: { token: token, exp: time.strftime('%Y-%m-%d %H:%M') })
  rescue StandardError => e
    Rails.logger.error("#{LOG_TAG} #{e.message}")
    Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

    Response.new(success?: false, message: e.message)
  end

  private

  attr_reader :email, :password, :user

  def create_token
    token = JsonWebToken.encode(user_id: user.id)
    time = 1.day.from_now

    [token, time]
  end
end
