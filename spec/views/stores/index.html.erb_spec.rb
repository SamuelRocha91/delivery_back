require 'rails_helper'

RSpec.describe "stores/index", type: :view do
  before(:each) do
    assign(:stores, [
      Store.create!(name: "Name", user: create(:user, :seller)),
      Store.create!(name: "Name", user: create(:user, :seller))
    ])
  end

  it "renders a list of stores" do
    render

    assert_select "div.store-card" do
      assert_select "span.store-name", text: "Name".to_s, count: 2
    end
  end
end

