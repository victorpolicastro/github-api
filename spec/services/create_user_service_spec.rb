# frozen_string_literal: true

RSpec.describe(CreateUserService) do
  let(:email)    { Faker::Internet.email                       }
  let(:password) { Faker::Alphanumeric.alphanumeric(number: 6) }

  context 'when invalid' do
    it 'ensures email presence' do
      response = described_class.new(nil, password).call

      expect(response.message).to(include("Validation failed: Email can't be blank"))
    end

    it 'ensures password presence' do
      response = described_class.new(email, nil).call

      expect(response.message).to(include("Validation failed: Password can't be blank"))
    end
  end

  context 'when valid' do
    it 'successfully creates a user' do
      response = described_class.new(email, password).call
      user = response.data

      expect(user.email).to(eq(email))
    end
  end
end
