require 'rails_helper'

describe 'Usuário cadastra pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep:'15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                      description: 'Galpão da zona portuária do Rio')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: 'abcd123456789', email: 'contato@acme.com',
                                full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP')

    Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                     registration_number: '123456789abcd', full_address: 'Av Industrial',
                     city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.brand_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: Date.tomorrow
    click_on 'Registrar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergio <sergio@email.com>'
    expect(page).to have_content "Data Prevista de Entrega: #{ I18n.localize Date.tomorrow}"
  end

  it 'e não informa a data de entrega' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep:'15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: 'abcd123456789', email: 'contato@acme.com',
                                full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP')

    login_as user
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
  end
end
