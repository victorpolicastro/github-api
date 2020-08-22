# frozen_string_literal: true

class SendRequestService
  include ActiveModel::Validations

  LOG_TAG = '[SEND REQUEST]:'
  private_constant :LOG_TAG

  validates :method, :endpoint, presence: true

  def initialize(method, endpoint, params)
    @method = method
    @endpoint = endpoint
    @params = params
  end

  def call
    raise_validation_error if invalid?

    response = RestClient::Request.execute(method: method.to_sym, url: endpoint, headers: { params: params })
    data = JSON.parse(response)

    Response.new(success?: true, data: data)
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error("#{LOG_TAG} #{e.message}")
    Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

    Response.new(success?: false, message: e.message)
  rescue StandardError => e
    Rails.logger.error("#{LOG_TAG} #{e.message}")
    Rails.logger.error("#{LOG_TAG} #{e.backtrace.join("\n")}")

    Response.new(success?: false, message: e.message)
  end

  private

  attr_reader :method, :endpoint, :params
end
