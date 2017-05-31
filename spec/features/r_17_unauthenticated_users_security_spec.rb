require 'rails_helper'

RSpec.describe "An unauthenticated user" do
  it "cannot view another user's private data" do
    user = create(:user)

    visit user_path(user)
    expect(page).to_not have_content user.username
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "must login or create an account to checkout" do
    item = create(:item)
    user = create(:user)

    visit items_path
    click_on "Add to Cart"
    click_on "My Cart"

    expect(page).to have_content "You must login to see your cart"
    expect(page).to have_content "Login"
    expect(page).to have_content "Create Account"

    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content user.username
    click_link "Cart"

    expect(page).to have_content item.name
    expect(page).to have_content item.price
    expect(page).to have_content item.image
  end

  it "cannot view the administrator screens" do
    visit admin_path(admin)
    expect(page).to_not have_content "Admin Dashboard"
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "cannot make themselves an administrator" do
    ### I think this could be tested by them just not having access to the admin dashboard...
    # I'm not really sure how else to test it?
    # Is there a way to test if a user has access to a database?
  end
end
