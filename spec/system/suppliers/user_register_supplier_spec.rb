require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela inical' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Número de registro'
    expect(page).to have_field 'Nome corporativo'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome fantasia', with: 'Boteco'
    fill_in 'Número de registro', with: '777'
    fill_in 'Nome corporativo', with: 'Boteco LTDA'
    fill_in 'Endereço', with: 'Logo ali'
    fill_in 'Cidade', with: 'Cupuaçu'
    fill_in 'Estado', with: 'MT'
    fill_in 'Email', with: 'boteco@mail.com'
    click_on 'Enviar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Boteco'
    expect(page).to have_content 'Cupuaçu - MT'
  end

  it 'com dados incompletos' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Número de registro não pode ficar em branco'
    expect(page).to have_content 'Nome corporativo não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
  end
end
