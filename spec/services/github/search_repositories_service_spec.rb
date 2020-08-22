# frozen_string_literal: true

RSpec.describe(Github::SearchRepositoriesService) do
  let(:send_request_service_call) { instance_double 'send_request_service_call' }
  let!(:send_request_service) do
    class_double(SendRequestService)
      .as_stubbed_const(transfer_nested_constants: true)
  end

  context 'when SendRequestService returns an error' do
    before do
      allow(send_request_service_call)
        .to(receive(:call)
        .and_return(OpenStruct.new(success?: false, message: Faker::Lorem.sentence)))
      allow(send_request_service).to(receive(:new).and_return(send_request_service_call))
    end

    let(:response) { described_class.new({}).call }

    it { expect(response.success?).to(be(false)) }
  end

  context 'when SendRequestService returns success' do
    before do
      allow(send_request_service_call)
        .to(receive(:call)
        .and_return(OpenStruct.new(success?: true, message: Faker::Lorem.sentence)))
      allow(send_request_service).to(receive(:new).and_return(send_request_service_call))
    end

    let(:response) { described_class.new({}).call }

    it { expect(response.success?).to(be(true)) }
  end
end
