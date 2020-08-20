# frozen_string_literal: true

RSpec.describe('Users endpoint', type: :request) do
  describe 'POST /api/v1/users' do
    let(:users_endpoint) { api_v1_users_path }
    let(:user)           { build(:user)      }
    let(:email)          { user.email        }
    let(:password)       { user.password     }

    context 'when request is invalid' do
      before do
        post(users_endpoint, params: { email: nil, password: password })
      end

      it { expect(response).to(have_http_status(:unprocessable_entity)) }
    end

    context 'when request is valid' do
      before do
        post(users_endpoint, params: { email: email, password: password })
      end

      it { expect(response).to(have_http_status(:ok)) }
    end
  end
end
