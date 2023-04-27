require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        warehouse =  Warehouse.new(name: '', code: 'RIO', city: 'Rio', area: 60_000,
          address: 'Endereço', cep:'20100-000', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false when code is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: '', city: 'Rio', area: 60_000,
          address: 'Endereço', cep:'20100-000', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false when city is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: 'RIO', city: '', area: 60_000,
          address: 'Endereço', cep:'20100-000', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false when area is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: nil,
          address: 'Endereço', cep:'20100-000', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false when address is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 60_000,
          address: '', cep:'20100-000', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false when cep is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 60_000,
          address: 'Endereço', cep:'', description: 'Galpão da zona portuária do Rio')

        expect(warehouse.valid?).to eq false
      end

      it 'false description is empty' do
        warehouse =  Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 60_000,
          address: 'Endereço', cep:'20100-000', description: '')

        expect(warehouse.valid?).to eq false
      end

    end

    context 'uniqueness' do
      it 'false when code is already in use' do
        first_warehouse =  Warehouse.create(name: 'Galpão Rio', code: 'RIO', city: 'Rio', area: 60_000,
                                          address: 'Endereço', cep:'20100-000',
                                          description: 'Galpão da zona portuária do Rio')

        second_warehouse =  Warehouse.new(name: 'Galpão SP', code: 'RIO', city: 'SP', area: 70_000,
                                          address: 'Novo Endereço', cep:'30100-000',
                                          description: 'Outra descrição')

        expect(second_warehouse).not_to be_valid
      end
    end

  end
end
