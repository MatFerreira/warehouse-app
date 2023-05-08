require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'fulano@mail.com', password: 'password')

    visit root_path

    within 'nav' do
      click_on 'Entrar'
    end

    within 'main > form' do
      fill_in 'E-mail', with: 'fulano@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_button 'Sair'
    expect(page).not_to have_link 'Entrar'
    within 'nav' do
      expect(page).to have_content 'fulano@mail.com'
    end
  end

  it 'e faz logout' do
    User.create!(email: 'fulano@mail.com', password: 'password')

    visit root_path

    within 'nav' do
      click_on 'Entrar'
    end

    within 'main > form' do
      fill_in 'E-mail', with: 'fulano@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'fulano@mail.com'
  end

end
