require 'rails_helper'

RSpec.describe "stores/edit", type: :view do
  let(:store) {
    Store.create!(
      name: "MyString",
      user: create(:user, :seller)
    )
  }

  let(:sellers) do
    [
      create(:user, :seller),
      create(:user, :seller)
    ]
  end
  before(:each) do
    assign(:store, store)
    assign(:sellers, sellers)
    allow(view).to receive(:current_user).and_return(create(:user, :admin))
  end

  it "renders the edit store form" do
    render

    assert_select "form[action=?][method=?]", store_path(store), "post" do

      assert_select "input[name=?]", "store[name]"
    end
  end
end
