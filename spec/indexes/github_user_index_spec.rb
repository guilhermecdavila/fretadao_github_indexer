require 'rails_helper'

RSpec.describe GithubUserIndex do
  let(:attrs) do
    {
      name: 'Guilherme',
      nickname: 'gui',
      organization: 'Fretadão',
      location: 'Brasil',
      github_url: 'https://github.com/guilherme'
    }
  end

  let(:github_user) { GithubUser.new(attrs) }

  describe '#search_data' do
    it 'retorna um hash com os dados corretos para indexação' do
      expect(github_user.search_data).to eq(attrs)
    end
  end

  describe '.included' do
    it 'inclui o searchkick na classe base' do
      expect(GithubUser).to respond_to(:searchkick)
    end
  end
end