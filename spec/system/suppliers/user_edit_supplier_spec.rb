require 'rails_helper'

describe 'Usuário edita fornecedor' do
  it 'a partir da tela de detalhes' do
    supplier = Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                                registration_number: '000000', full_address: 'Av Industrial',
                                city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')
    visit root_path
    click_on 'Fornecedores'
    click_on 'Marca'
    click_on 'Editar'

    expect(page).to have_field 'Nome corporativo', with: 'Industria ex'
    expect(page).to have_field 'Nome fantasia', with: 'Marca'
    expect(page).to have_field 'Número de registro', with: '000000'
    expect(page).to have_field 'Endereço', with: 'Av Industrial'
    expect(page).to have_field 'Cidade', with: 'Lugar nenhum'
    expect(page).to have_field 'Estado', with: 'ex'
    expect(page).to have_field 'Email', with: 'exemplo@mail.com'
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                                registration_number: '000000', full_address: 'Av Industrial',
                                city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Marca'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'Boteco'
    fill_in 'Número de registro', with: '777'
    fill_in 'Nome corporativo', with: 'Boteco LTDA'
    fill_in 'Endereço', with: 'Logo ali'
    fill_in 'Cidade', with: 'Cupuaçu'
    fill_in 'Estado', with: 'MT'
    fill_in 'Email', with: 'boteco@mail.com'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Boteco'
    expect(page).to have_content '777'
    expect(page).to have_content 'Boteco LTDA'
    expect(page).to have_content  'Logo ali'
    expect(page).to have_content 'Cupuaçu'
    expect(page).to have_content 'MT'
    expect(page).to have_content 'boteco@mail.com'
  end

  it 'com dados imcompletos' do
    supplier = Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                                registration_number: '000000', full_address: 'Av Industrial',
                                city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Marca'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'Número de registro', with: ''
    fill_in 'Nome corporativo', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não atualizado'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Número de registro não pode ficar em branco'
    expect(page).to have_content 'Nome corporativo não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
  end
end
