require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep:'15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: 'abcd123456789', email: 'contato@acme.com',
                                  full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier,
                        estimated_delivery_date: 1.day.from_now)

      expect(order).to be_valid
    end

    it 'data estimada de entrega deve ser obrigatória' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep:'15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: 'abcd123456789', email: 'contato@acme.com',
                                  full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier,
                        estimated_delivery_date: '')
      order.valid?

      # expect(order).not_to be_valid
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
  end

  it 'data estimada de entrega não deve ser passada' do
    order = Order.new(estimated_delivery_date: Date.yesterday)

    order.valid?
    result = order.errors.include? :estimated_delivery_date

    expect(result).to be true
    expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura'
  end

  it 'data estimada de entrega não deve ser igual a hoje' do
    order = Order.new(estimated_delivery_date: Date.today)

    order.valid?

    expect(order.errors.include? :estimated_delivery_date).to be true
    expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura'
  end

  it 'date estimada de entrega deve ser igual ou maior que amanhã' do
    order = Order.new(estimated_delivery_date: Date.tomorrow)

    order.valid?

    expect(order.errors.include? :estimated_delivery_date).to be false
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep:'15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: 'abcd123456789', email: 'contato@acme.com',
                                  full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP')
      first_order = Order.new(user: user, warehouse: warehouse,
                              supplier: supplier, estimated_delivery_date: 1.day.from_now)
      second_order = Order.new(user: user, warehouse: warehouse,
                              supplier: supplier, estimated_delivery_date: 1.day.from_now)

      first_order.save!
      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end
  end
end
