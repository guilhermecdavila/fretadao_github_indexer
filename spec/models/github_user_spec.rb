require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  subject { described_class.new(name: 'Guilherme', github_url: 'https://github.com/guilhermecdavila') }

  describe 'validações' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:github_url) }
    it { should validate_uniqueness_of(:github_url) }
    it { should allow_value('https://github.com/test').for(:github_url) }
    it { should_not allow_value('invalid_url').for(:github_url) }
  end

  describe 'callbacks' do
    it 'chama start_webscrapper após criar' do
      expect_any_instance_of(GithubUser).to receive(:start_webscrapper)
      subject.save
    end

    it 'chama encrypt_github_url após criar' do
      expect_any_instance_of(GithubUser).to receive(:encrypt_github_url)
      subject.save
    end

    it 'chama reindex após criar, atualizar ou destruir' do
      expect_any_instance_of(GithubUser).to receive(:reindex).at_least(:once)
      subject.save
      subject.update(name: 'Novo Nome')
      subject.destroy
    end
  end

  describe '#encrypt_github_url' do
    it 'atualiza encripted_github_url com a url encurtada' do
      allow(TinyurlShortener).to receive(:shorten).and_return('http://tiny.url/abc')
      subject.save
      expect(subject.encripted_github_url).to eq('http://tiny.url/abc')
    end

    it 'não atualiza se encripted_github_url já estiver presente' do
      subject.encripted_github_url = 'http://tiny.url/existente'
      expect(subject).not_to receive(:update)
      subject.encrypt_github_url
    end
  end

  describe '#start_webscrapper' do
    it 'atualiza atributos com resultado do WebscrapperService' do
      result = { name: 'Novo Nome' }
      allow_any_instance_of(WebscrapperService).to receive(:scam).and_return(result)
      expect(subject).to receive(:update).with(result)
      subject.start_webscrapper
    end

    it 'não atualiza se resultado estiver vazio' do
      allow_any_instance_of(WebscrapperService).to receive(:scam).and_return(nil)
      expect(subject).not_to receive(:update)
      subject.start_webscrapper
    end
  end
end