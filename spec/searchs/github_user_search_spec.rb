require 'rails_helper'

RSpec.describe GithubUserSearch do
  let(:query) { 'guilherme' }
  let(:options) { { custom: 'value' } }
  let(:search_instance) { described_class.new(query, options) }
  let(:mock_results) { [double('GithubUser', id: 1), double('GithubUser', id: 2)] }

  describe '#search' do
    it 'chama GithubUser.search com query e options e retorna os resultados' do
      expect(GithubUser).to receive(:search).with(query, hash_including(:custom)).and_return(mock_results)
      expect(search_instance.search).to eq(mock_results)
    end

    it 'adiciona opções padrão antes de chamar GithubUser.search' do
      expect(GithubUser).to receive(:search) do |_, opts|
        expect(opts).to include(:fields, :operator, :limit, :body_options, :misspellings)
        mock_results
      end
      search_instance.search
    end
  end
end