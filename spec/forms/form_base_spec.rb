require 'rails_helper'

RSpec.describe FormBase do
  class DummyForm < FormBase
    attr_accessor :foo, :bar
  end

  let(:attributes) { { foo: 'abc', bar: 123 } }
  let(:form) { DummyForm.new(attributes) }

  it 'atribui os valores corretamente' do
    expect(form.foo).to eq('abc')
    expect(form.bar).to eq(123)
  end

  it 'não é persistido' do
    expect(form.persisted?).to be_falsey
  end

  it 'ignora atributos desconhecidos' do
    expect { DummyForm.new(baz: 'nope') }.not_to raise_error
  end
end