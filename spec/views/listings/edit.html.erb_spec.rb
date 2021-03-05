require 'rails_helper'

RSpec.describe "listings/edit", type: :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
      user: nil,
      type: nil,
      name: "MyString",
      price: 1.5,
      description: "MyText"
    ))
  end

  it "renders the edit listing form" do
    render

    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do

      assert_select "input[name=?]", "listing[user_id]"

      assert_select "input[name=?]", "listing[type_id]"

      assert_select "input[name=?]", "listing[name]"

      assert_select "input[name=?]", "listing[price]"

      assert_select "textarea[name=?]", "listing[description]"
    end
  end
end
