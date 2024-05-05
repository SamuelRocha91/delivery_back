require 'rails_helper'

RSpec.describe "stores/new", type: :view do
  let(:sellers) do
    [
      create(:user, email: "seller1@example.com", role: 'seller'),
      create(:user, email: "seller2@example.com", role: 'seller'),
      create(:user, email: "seller3@example.com", role: 'seller')
    ]
  end
  
  
  before(:each) do
    assign(:store, Store.new(
      name: "MyString"
    ))

    assign(:sellers, sellers)
    allow(view).to receive(:current_user).and_return(create(:user_admin))
  end

  it "renders new store form" do
    render

    assert_select "form[action=?][method=?]", stores_path, "post" do

      assert_select "input[name=?]", "store[name]"
    end
  end
end
