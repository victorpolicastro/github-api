# frozen_string_literal: true

class Response < Struct.new(:success?, :message, :data, keyword_init: true)
end
