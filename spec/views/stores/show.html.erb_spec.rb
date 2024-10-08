require 'rails_helper'

RSpec.describe "stores/show", type: :view do
  before(:each) do
    assign(:store, Store.create!(
      name: "Name",
      user: create(:user, :seller)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
