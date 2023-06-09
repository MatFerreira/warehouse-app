require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                                  description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Avenida do Museu do amanhã, 1000' )
    expect(page).to have_field('CEP', with: '20100-000')
    expect(page).to have_field('Descrição', with: 'Galpão da zona portuária do Rio' )
  end

  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                                  description: 'Galpão da zona portuária do Rio')

      visit root_path
      click_on 'Rio'
      click_on 'Editar'
      fill_in 'Nome', with: 'Galpão Internacional'
      fill_in 'Área', with: '20000'
      fill_in 'CEP', with: '16000-000'
      fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
      click_on 'Enviar'

      expect(page).to have_content 'Galpão atualizado com sucesso'
      expect(page).to have_content 'Nome: Galpão Internacional'
      expect(page).to have_content 'Área: 20000 m²'
      expect(page).to have_content 'CEP: 16000-000'
      expect(page).to have_content 'Endereço: Avenida dos Galpões, 500'
  end

  it 'e mantém os campos obrigatórios' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                                  description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end
