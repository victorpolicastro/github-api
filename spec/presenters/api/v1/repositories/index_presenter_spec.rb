# frozen_string_literal: true

RSpec.describe(Api::V1::Repositories::IndexPresenter) do
  describe '#attributes' do
    let!(:repositories)        { [repository, repository]                     }
    let(:data)                 { described_class.new(repositories).attributes }
    let(:first_repository)     { repositories.first                           }
    let(:formatted_repository) { data.first                                   }

    it { expect(data).not_to(be_blank) }
    it { expect(formatted_repository[:full_name]).to(eq(first_repository[:full_name])) }
    it { expect(formatted_repository[:description]).to(eq(first_repository[:description])) }
    it { expect(formatted_repository[:stars]).to(eq(first_repository[:stargazers_count])) }
    it { expect(formatted_repository[:forks]).to(eq(first_repository[:forks])) }
    it { expect(formatted_repository[:owner]).to(eq(first_repository[:owner][:login].to_s)) }
  end
end

private

def repository
  {
    full_name: Faker::Lorem.word,
    description: Faker::Lorem.sentence,
    stargazers_count: Faker::Number.number(digits: 4).to_s,
    forks: Faker::Number.number(digits: 4).to_s,
    owner: {
      login: Faker::Internet.username
    }
  }
end
