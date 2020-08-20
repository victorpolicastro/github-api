# frozen_string_literal: true

RSpec.describe('Authentications endpoint', type: :request) do
  describe 'POST /api/v1/auth/login' do
    let(:authentications_endpoint) { api_v1_auth_login_path                      }
    let(:password)                 { Faker::Alphanumeric.alphanumeric(number: 6) }
    let!(:user)                    { create(:user, password: password)           }

    context 'when user inserts the wrong password' do
      before do
        post(
          authentications_endpoint, params: { email: user.email, password: Faker::Alphanumeric.alphanumeric(number: 6) }
        )
      end

      it { expect(response).to(have_http_status(:unauthorized)) }
    end

    context 'when user inserts the correct password' do
      before do
        post(authentications_endpoint, params: { email: user.email, password: password })
      end

      it { expect(response).to(have_http_status(:ok)) }
    end
  end
end
