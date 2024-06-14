require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do

  describe "GET #index" do
    
  before(:each) {allow(view).to receive(:current_user).and_return(nil)}

    it "displays the welcome message" do
      render
      expect(rendered).to match(/Bem vindo ao Delivery!/)
    end

    it "displays the login link" do
      render
      expect(rendered).to match(/<a href="\/users\/sign_in">Sign in<\/a>/)
    end
  end

  describe "GET #index" do
          
          before(:each) {allow(view).to receive(:current_user).and_return(create(:user, :admin))}
      
          it "displays the welcome message" do
            render
            expect(rendered).to match(/Bem vindo ao Delivery!/)
          end
      
          it "displays the header with links" do
            render
            expect(rendered).to match(/<a href="\/stores">Lojas<\/a>/)
            expect(rendered).to match(/<a href="\/users">Usuários<\/a>/)
            expect(rendered).to match(/<a href="\/listing">Produtos<\/a>/)
            expect(rendered).to match(/<a href="\/buyers\/orders">Gerenciar pedidos<\/a>/)
            expect(rendered).to include('<form class="button_to" method="post" action="/users/sign_out"><input type="hidden" name="_method" value="delete" autocomplete="off" /><button type="submit">Sair</button></form>')
          end
      end
  end