require 'rails_helper'

describe 'Usuário visita index de fornecedores' do
  it 'e vê lista de cadastro' do
    supplier = Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                                registration_number: '123456789abcd', full_address: 'Av Industrial',
                                city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Lugar nenhum - ex'
  end

  it 'e a lista está vazia' do
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Não há fornecedores cadastrados'
  end
end
