# frozen_string_literal: true

RSpec.describe(AuthenticateUserService) do
  let(:password) { Faker::Alphanumeric.alphanumeric(number: 6) }
  let!(:user)    { create(:user, password: password)           }
  let(:email)    { user.email                                  }

  context 'when invalid' do
    it 'ensures email presence' do
      response = described_class.new(nil, password).call

      expect(response.message).to(include("Validation failed: Email can't be blank"))
    end

    it 'ensures password presence' do
      response = described_class.new(email, nil).call

      expect(response.message).to(include("Validation failed: Password can't be blank"))
    end

    it 'ensures user presence' do
      response = described_class.new(Faker::Internet.email, password).call

      expect(response.message).to(include("Validation failed: User can't be blank"))
    end
  end

  context 'when user inserts the wrong password' do
    let(:response) { described_class.new(email, Faker::Alphanumeric.alphanumeric(number: 6)).call }

    it { expect(response.message).to(include('There was an error in your authentication')) }
  end

  context 'when valid' do
    let(:response) { described_class.new(email, password).call }

    it { expect(response.data[:exp].to_date).to(eq(1.day.from_now.to_date)) }
  end
end
