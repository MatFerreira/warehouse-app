require 'rails_helper'

describe 'Usuário visualiza modelos de produto' do
  it 'a partir do menu' do
    visit root_path
    within 'nav' do
      click_on "Modelos de Produtos"
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                        registration_number: '123456789abcd', full_address: 'Av Nacoes Unidas, 1000',
                        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000 , width: 70, height: 45, depth: 10,
                        sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

    ProductModel.create!(name: 'SoundBar Surround', weight: 3000 , width: 80, height: 15, depth: 20,
                          sku: 'SOU71-SAMG-NOIZ77', supplier: supplier)

    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar Surround'
    expect(page).to have_content 'SOU71-SAMG-NOIZ77'
    expect(page).to have_content 'Samsung'
  end

  it 'e não há produtos cadastrados' do
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Nenhum produto cadastrado'
  end
end
