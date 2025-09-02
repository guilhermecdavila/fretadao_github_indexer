require 'rails_helper'

class DummySearch < SearchBase
  def search
    [OpenStruct.new(id: 1), OpenStruct.new(id: 2)]
  end
end

RSpec.describe SearchBase do
  let(:query) { 'guilherme' }
  let(:options) { { custom: 'value' } }
  let(:search) { DummySearch.new(query, options) }

  describe '#initialize' do
    it 'atribui query e options corretamente' do
      expect(search.send(:query)).to eq(query)
      expect(search.send(:options)).to include(:custom)
    end
  end

  describe '#search_ids' do
    it 'retorna os ids dos resultados da busca como inteiros' do
      expect(search.search_ids).to eq([1, 2])
    end

    it 'adiciona opções de select e limit' do
      search.search_ids
      expect(search.send(:options)).to include(:select)
      expect(search.send(:options)).to include(:limit)
    end

    it 'adiciona opções padrão' do
      search.search_ids
      expect(search.send(:options)).to include(:fields, :operator, :body_options, :misspellings)
    end
  end
end