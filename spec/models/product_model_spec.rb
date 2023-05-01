require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      sup = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                              registration_number: '123456789abcd', full_address: 'Av Nacoes Unidas, 1000',
                              city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: '', weight: 8000 , width: 70, height: 45, depth: 10,
                                sku: 'TV32-SAMSU-XPTO90', supplier: sup)

      expect(pm).not_to be_valid
    end

    it 'SKU is mandatory' do
      sup = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                              registration_number: '123456789abcd', full_address: 'Av Nacoes Unidas, 1000',
                              city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 32', weight: 8000 , width: 70, height: 45, depth: 10,
                                sku: '', supplier: sup)

      expect(pm).not_to be_valid
    end

  end
end
