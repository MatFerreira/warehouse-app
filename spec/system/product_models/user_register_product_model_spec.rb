require 'rails_helper'

describe 'Usuário cadastra modelo de produto' do
  it 'com sucesso' do
    user = User.create!(name: 'Fulano', email: 'fulano@mail.com', password: 'password')

    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                registration_number: '123456789abcd', full_address: 'Av Nacoes Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA',
                    registration_number: 'abcd123456789', full_address: 'Av Nacoes Separadas, 1000',
                    city: 'Rio', state: 'RJ', email: 'sac@lg.com.br')

    login_as user
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-XPTO'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV40-SAMS-XPTO'
    expect(page).to have_content 'Dimensões: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end

  it 'com dados incompletos' do
    user = User.create!(name: 'Fulano', email: 'fulano@mail.com', password: 'password')

    login_as user
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Produto'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo de produto não cadastrado'
  end
end
