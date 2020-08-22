# frozen_string_literal: true

RSpec.describe('Repositories endpoint', type: :request) do
  describe 'GET /api/v1/repositories' do
    let(:repositories_endpoint)            { api_v1_repositories_path                                           }
    let(:github_endpoint)                  { 'https://api.github.com/search/repositories'                       }
    let!(:user)                            { create(:user)                                                      }
    let(:token)                            { JsonWebToken.encode(user_id: user.id, exp: 24.hours.from_now.to_i) }
    let(:jwt)                              { "Bearer #{token}"                                                  }
    let(:search_repositories_service_call) { instance_double 'search_repositories_service_call'                 }
    let(:index_presenter_attributes)       { instance_double 'index_presenter_attributes'                       }
    let!(:search_repositories_service) do
      class_double(Github::SearchRepositoriesService).as_stubbed_const(transfer_nested_constants: true)
    end
    let!(:index_presenter) do
      class_double(Api::V1::Repositories::IndexPresenter).as_stubbed_const(transfer_nested_constants: true)
    end

    context 'when Github::SearchRepositoriesService returns an error' do
      before do
        allow(search_repositories_service_call)
          .to(receive(:call)
          .and_return(OpenStruct.new(success?: false, message: Faker::Lorem.sentence)))
        allow(search_repositories_service).to(receive(:new).and_return(search_repositories_service_call))
        get(repositories_endpoint, headers: { authorization: jwt })
      end

      it { expect(response).to(have_http_status(:unprocessable_entity)) }
    end

    context 'when success' do
      before do
        allow(search_repositories_service_call).to(receive(:call).and_return(OpenStruct.new(success?: true, data: {})))
        allow(search_repositories_service).to(receive(:new).and_return(search_repositories_service_call))
        allow(index_presenter_attributes).to(receive(:attributes).and_return(OpenStruct.new({})))
        allow(index_presenter).to(receive(:new).and_return(index_presenter_attributes))
        get(repositories_endpoint, headers: { authorization: jwt })
      end

      it { expect(response).to(have_http_status(:ok)) }
    end
  end
end
