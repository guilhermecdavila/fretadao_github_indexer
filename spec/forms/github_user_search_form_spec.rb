require 'rails_helper'

RSpec.describe GithubUserSearchForm do
  subject { described_class.new(query: query) }

  context 'quando query está presente' do
    let(:query) { 'guilherme' }

    it 'é válido' do
      expect(subject).to be_valid
    end
  end

  context 'quando query está ausente' do
    let(:query) { nil }

    it 'não é válido' do
      expect(subject).not_to be_valid
      expect(subject.errors[:query]).to include("não pode ficar em branco")
    end
  end
end