require 'rails_helper'

RSpec.describe "visitor can create an account" do
  scenario "visitor can get to new account page" do
    visit root_path
    expect(page).to have_content("Login")

    click_link "Login"
    expect(current_path).to eq(login_path)

    expect(page).to have_content("Create Account")
  end

  scenario "visitor can create a new account" do
    visit login_path

    click_link "Create Account"

    fill_in "user[first_name]", with: "zuzu"
    fill_in "user[last_name]", with: "Thomas"
    fill_in "Email", with: "meatball_lover@puppy.com"
    fill_in "user[username]", with: "zuzu_puppy"
    fill_in "Password", with: "meatball"
    fill_in "Address", with: "121 zuzu"
    fill_in "State", with: "CO"
    fill_in "City", with: "Zuzu"
    fill_in "Zipcode", with: "80120"
    #fill_in "Password Confirm", with: "meatball"

    click_button "Create Account"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Logged in as zuzu")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")
  end

  scenario "visitor can not create new account without username" do
    visit login_path

    click_link "Create Account"

    fill_in "user[first_name]", with: "zuzu"
    fill_in "user[last_name]", with: "Thomas"
    fill_in "Password", with: "meatball"
    fill_in "Email", with: "meatball_lover@puppy.com"

    click_button "Create Account"

    expect(page).to have_content("Please complete requirements before creating account")
  end

  scenario "visitor can not create new account without password" do
    visit login_path

    click_link "Create Account"

    fill_in "user[first_name]", with: "zuzu"
    fill_in "user[last_name]", with: "Thomas"
    fill_in "Username", with: "zuzu_puppy"
    fill_in "Email", with: "meatball_lover@puppy.com"

    click_button "Create Account"

    expect(page).to have_content("Please complete requirements before creating account")
  end

  scenario "visitor can not create new account without email" do
    visit login_path

    click_link "Create Account"

    fill_in "user[first_name]", with: "zuzu"
    fill_in "user[last_name]", with: "Thomas"
    fill_in "Username", with: "zuzu_puppy"
    fill_in "Password", with: "meatball"

    click_button "Create Account"

    expect(page).to have_content("Please complete requirements before creating account")
  end
end
