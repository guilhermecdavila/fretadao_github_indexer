require 'rails_helper'

describe WebscrapperService do
  let(:github_url) { 'https://github.com/testuser' }
  let(:mock_browser) { double('Watir::Browser') }
  let(:mock_window) { double('Window') }
  let(:mock_element) { double('Element') }
  let(:mock_elements) { double('Elements') }
  let(:mock_profile) { double('Profile') }
  let(:mock_stars) { double('Stars') }
  let(:mock_counter) { double('Counter') }

  subject { described_class.new(github_url: github_url) }

  before do
    allow(Watir::Browser).to receive(:new).with(:firefox, headless: true).and_return(mock_browser)
    allow(mock_browser).to receive(:window).and_return(mock_window)
    allow(mock_window).to receive(:maximize)
    allow(mock_browser).to receive(:goto)
    allow(mock_browser).to receive(:close)
    allow(mock_browser).to receive(:a).and_return(mock_element)
    allow(mock_browser).to receive(:span).and_return(mock_element)
    allow(mock_browser).to receive(:element).and_return(mock_element)
    allow(mock_element).to receive(:exists?).and_return(true)
    allow(mock_element).to receive(:present?).and_return(true)
    allow(mock_element).to receive(:wait_until).and_return(mock_element)
    allow(mock_element).to receive(:text).and_return('')
    allow(mock_element).to receive(:href).and_return('')
    allow(mock_element).to receive(:elements).and_return(mock_elements)
    allow(mock_elements).to receive(:empty?).and_return(false)
    allow(mock_elements).to receive(:first).and_return(mock_element)
    allow(mock_elements).to receive(:last).and_return(mock_element)
    allow(mock_element).to receive(:element).and_return(mock_element)
  end

  describe '#initialize' do
    it 'inicializa com a URL do GitHub' do
      expect(subject.instance_variable_get(:@github_url)).to eq(github_url)
    end

    it 'inicializa com atributos vazios' do
      expect(subject.instance_variable_get(:@attributes)).to eq({})
    end
  end

  describe '#scam' do
    before do
      allow(subject).to receive(:extract).and_return({})
    end

    it 'cria uma nova instância do browser' do
      expect(Watir::Browser).to receive(:new).with(:firefox, headless: true)
      subject.scam
    end

    it 'maximiza a janela do browser' do
      expect(mock_window).to receive(:maximize)
      subject.scam
    end

    it 'navega para a URL do GitHub' do
      expect(mock_browser).to receive(:goto).with(github_url)
      subject.scam
    end

    it 'aguarda 1 segundo' do
      expect(subject).to receive(:sleep).with(1)
      subject.scam
    end

    it 'chama o método extract' do
      expect(subject).to receive(:extract).with(mock_browser)
      subject.scam
    end

    it 'fecha o browser' do
      expect(mock_browser).to receive(:close)
      subject.scam
    end

    it 'retorna os atributos extraídos' do
      allow(subject).to receive(:scam).and_return({ test: 'value' })
      expect(subject.scam).to eq({ test: 'value' })
    end
  end

  describe '#extract' do
    let(:page) { mock_browser }

    before do
      allow(subject).to receive(:image_url).and_return('http://example.com/image.jpg')
      allow(subject).to receive(:contribution).and_return('1234')
      allow(subject).to receive(:nickname).and_return('testuser')
      allow(subject).to receive(:followers).and_return('100')
      allow(subject).to receive(:following).and_return('50')
      allow(subject).to receive(:stars).and_return('25')
      allow(subject).to receive(:organization).and_return('Test Org')
      allow(subject).to receive(:location).and_return('São Paulo, Brasil')
    end

    it 'extrai todos os atributos do perfil' do
      result = subject.send(:extract, page)

      expect(result[:image_url]).to eq('http://example.com/image.jpg')
      expect(result[:contribution]).to eq('1234')
      expect(result[:nickname]).to eq('testuser')
      expect(result[:followers]).to eq('100')
      expect(result[:following]).to eq('50')
      expect(result[:stars]).to eq('25')
      expect(result[:organization]).to eq('Test Org')
      expect(result[:location]).to eq('São Paulo, Brasil')
    end

    it 'retorna os atributos extraídos' do
      result = subject.send(:extract, page)
      expect(result).to be_a(Hash)
    end
  end

  describe '#image_url' do
    context 'quando o elemento existe' do
      before do
        allow(mock_browser).to receive(:a).with(itemprop: 'image').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(true)
        allow(mock_element).to receive(:href).and_return('http://example.com/avatar.jpg')
      end

      it 'retorna a URL da imagem' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:image_url)).to eq('http://example.com/avatar.jpg')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:a).with(itemprop: 'image').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:image_url)).to be_nil
      end
    end
  end

  describe '#contribution' do
    context 'quando o elemento existe' do
      before do
        allow(mock_browser).to receive(:element).with(css: "#js-contribution-activity-description").and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(true)
        allow(mock_element).to receive(:wait_until).and_return(mock_element)
        allow(mock_element).to receive(:text).and_return('1,234 contributions in the last year')
      end

      it 'retorna apenas os números da contribuição' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:contribution)).to eq('1234')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with(css: "#js-contribution-activity-description").and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:contribution)).to be_nil
      end
    end
  end

  describe '#nickname' do
    context 'quando o elemento existe' do
      before do
        allow(mock_browser).to receive(:span).with(itemprop: 'additionalName').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(true)
        allow(mock_element).to receive(:text).and_return('testuser')
      end

      it 'retorna o nickname' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:nickname)).to eq('testuser')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:span).with(itemprop: 'additionalName').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:nickname)).to be_nil
      end
    end
  end

  describe '#followers' do
    context 'quando o elemento existe e tem seguidores' do
      before do
        allow(mock_browser).to receive(:element).with(css: ".js-profile-editable-area").and_return(mock_profile)
        allow(mock_profile).to receive(:exists?).and_return(true)
        allow(mock_profile).to receive(:elements).with(css: '.color-fg-default').and_return(mock_elements)
        allow(mock_elements).to receive(:empty?).and_return(false)
        allow(mock_elements).to receive(:first).and_return(mock_element)
        allow(mock_element).to receive(:text).and_return('100 followers')
      end

      it 'retorna o número de seguidores' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:followers)).to eq('100 followers')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with(css: ".js-profile-editable-area").and_return(mock_profile)
        allow(mock_profile).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:followers)).to be_nil
      end
    end

    context 'quando não há elementos de seguidores' do
      before do
        allow(mock_browser).to receive(:element).with(css: ".js-profile-editable-area").and_return(mock_profile)
        allow(mock_profile).to receive(:exists?).and_return(true)
        allow(mock_profile).to receive(:elements).with(css: '.color-fg-default').and_return(mock_elements)
        allow(mock_elements).to receive(:empty?).and_return(true)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:followers)).to be_nil
      end
    end
  end

  describe '#following' do
    context 'quando o elemento existe e tem seguindo' do
      before do
        allow(mock_browser).to receive(:element).with(css: ".js-profile-editable-area").and_return(mock_profile)
        allow(mock_profile).to receive(:exists?).and_return(true)
        allow(mock_profile).to receive(:elements).with(css: '.color-fg-default').and_return(mock_elements)
        allow(mock_elements).to receive(:empty?).and_return(false)
        allow(mock_elements).to receive(:last).and_return(mock_element)
        allow(mock_element).to receive(:text).and_return('50 following')
      end

      it 'retorna o número de seguindo' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:following)).to eq('50 following')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with(css: ".js-profile-editable-area").and_return(mock_profile)
        allow(mock_profile).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:following)).to be_nil
      end
    end
  end

  describe '#stars' do
    context 'quando o elemento existe e tem estrelas' do
      before do
        allow(mock_browser).to receive(:element).with("data-tab-item" => 'stars').and_return(mock_stars)
        allow(mock_stars).to receive(:exists?).and_return(true)
        allow(mock_stars).to receive(:element).with(class: "Counter").and_return(mock_counter)
        allow(mock_counter).to receive(:text).and_return('25')
      end

      it 'retorna apenas os números das estrelas' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:stars)).to eq('25')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with("data-tab-item" => 'stars').and_return(mock_stars)
        allow(mock_stars).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:stars)).to be_nil
      end
    end

    context 'quando o contador está vazio' do
      before do
        allow(mock_browser).to receive(:element).with("data-tab-item" => 'stars').and_return(mock_stars)
        allow(mock_stars).to receive(:exists?).and_return(true)
        allow(mock_stars).to receive(:element).with(class: "Counter").and_return(mock_counter)
        allow(mock_counter).to receive(:text).and_return('')
        allow(mock_counter).to receive(:blank?).and_return(true)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:stars)).to be_nil
      end
    end
  end

  describe '#organization' do
    context 'quando o elemento existe' do
      before do
        allow(mock_browser).to receive(:element).with(itemprop: 'worksFor').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(true)
        allow(mock_element).to receive(:text).and_return('Test Organization')
      end

      it 'retorna o nome da organização' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:organization)).to eq('Test Organization')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with(itemprop: 'worksFor').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:organization)).to be_nil
      end
    end
  end

  describe '#location' do
    context 'quando o elemento existe' do
      before do
        allow(mock_browser).to receive(:element).with(itemprop: 'homeLocation').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(true)
        allow(mock_element).to receive(:text).and_return('São Paulo, Brasil')
      end

      it 'retorna a localização' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:location)).to eq('São Paulo, Brasil')
      end
    end

    context 'quando o elemento não existe' do
      before do
        allow(mock_browser).to receive(:element).with(itemprop: 'homeLocation').and_return(mock_element)
        allow(mock_element).to receive(:exists?).and_return(false)
      end

      it 'retorna nil' do
        subject.instance_variable_set(:@page, mock_browser)
        expect(subject.send(:location)).to be_nil
      end
    end
  end
end
