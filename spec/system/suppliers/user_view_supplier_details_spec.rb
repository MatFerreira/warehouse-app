require 'rails_helper'

describe 'Usuário acessa detalhes de um fornecedor' do
  it 'e visualiza informações adicionais' do
    supplier = Supplier.create!(corporate_name: 'Industria ex', brand_name: 'Marca',
                                registration_number: '000000', full_address: 'Av Industrial',
                                city: 'Lugar nenhum', state: 'ex', email: 'exemplo@mail.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Marca'

    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Nome corporativo: Industria ex'
    expect(page).to have_content 'Número de registro: 000000'
    expect(page).to have_content 'Endereço: Av Industrial'
    expect(page).to have_content 'Cidade: Lugar nenhum'
    expect(page).to have_content 'Estado: ex'
    expect(page).to have_content 'Email: exemplo@mail.com'

  end
end
