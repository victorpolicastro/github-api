# frozen_string_literal: true

RSpec.describe(User, type: :model) do
  let(:user) { build(:user) }

  context 'when invalid' do
    it 'ensures email presence' do
      user.email = nil

      expect(user).not_to(be_valid)
    end

    it 'ensures password presence' do
      user.password = nil

      expect(user).not_to(be_valid)
    end

    it 'ensures email is unique' do
      user.save!
      new_user = build(:user, email: user.email)

      expect(new_user).not_to(be_valid)
    end

    it 'ensures password minimum length' do
      user.password = Faker::Alphanumeric.alphanumeric(number: 5)

      expect(user).not_to(be_valid)
    end
  end

  context 'when valid' do
    it { expect(user).to(be_valid) }
  end
end
