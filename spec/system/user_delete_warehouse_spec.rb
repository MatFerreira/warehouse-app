require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                                  description: 'Galpão da zona portuária do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Rio'
  end

  it 'e não apaga outros galpões' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do Museu do amanhã, 1000', cep:'20100-000',
                                  description: 'Galpão da zona portuária do Rio')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000,
                                  address: 'Av Tiradentes, 20', cep:'46000-000',
                                  description: 'Galpão para cargas mineiras')
    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Rio'
  end
end
