# frozen_string_literal: true

RSpec.describe(SendRequestService) do
  let(:method)      { 'get'                                        }
  let(:endpoint)    { 'https://api.github.com/search/repositories' }
  let(:sent_params) { params                                       }
  let(:filters)     { options(sent_params)                         }

  context 'when invalid' do
    it 'ensures method presence' do
      response = described_class.new(nil, endpoint, nil).call

      expect(response.message).to(include("Validation failed: Method can't be blank"))
    end

    it 'ensures endpoint presence' do
      response = described_class.new(method, nil, nil).call

      expect(response.message).to(include("Validation failed: Endpoint can't be blank"))
    end
  end

  context 'when valid' do
    before { stub_request(:get, stub_url).to_return(status: 200, body: '{}') }

    let(:response) { described_class.new(method, endpoint, filters).call }

    it { expect(response.success?).to(be(true)) }
  end

  context 'when api returns an error' do
    before { stub_request(:get, stub_url).to_return(status: 422, body: 'Unprocessable Entity') }

    let(:response) { described_class.new(method, endpoint, filters).call }

    it { expect(response.success?).to(be(false)) }
  end
end

private

def params
  {
    sort: %w[stars forks updated].sample,
    order: %w[asc desc].sample,
    page: Faker::Number.number(digits: 2),
    per_page: Faker::Number.number(digits: 2)
  }
end

def options(sent_params)
  {
    q: 'language:ruby',
    sort: sent_params[:sort],
    order: sent_params[:order],
    page: sent_params[:page],
    per_page: sent_params[:per_page]
  }
end

def stub_url
  order = sent_params[:order]
  page = sent_params[:page]
  per_page = sent_params[:per_page]
  sort = sent_params[:sort]

  <<~HEREDOC
    #{ENV['GITHUB_API']}?order=#{order}&page=#{page}&per_page=#{per_page}&q=language:ruby&sort=#{sort}
  HEREDOC
end
