describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    # Arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'São Paulo', area: 100_000,
                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                        description: 'Galpão destinado para cargas internacionais')
    w.save()

    # Act
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: São Paulo')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Área: 100000 m²')
  end

  it 'e retorna a página incial' do
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'São Paulo', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    w.save()

    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
