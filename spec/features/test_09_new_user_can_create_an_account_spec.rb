require 'rails_helper'

RSpec.describe "visitor can create an account" do
  scenario "visitor can get to new account page" do
    visit root_path
    escpect(page).to have_content "Login"

    click_link "Login"
    expect(current_path).to eq(login_path)

    find("input[placeholder='Username']")
    find("input[placeholder='Password']")

    expect(page).to have_content("Create Account")
  end

  scenario "visitor can create a new account" do
    visit login_path
    click_link "Create Account"

    fill_in "Name", with: "zuzu"
    fill_in "Username", with: "zuzu_puppy"
    fill_in "Password", with: "meatball"
    fill_in "Password Confirm", with: "meatball"

    click_button "Create Account"
# Does current path reroute back to the root path or a new user path???
    expect(current_path).to eq("root_path")
    expect(page).to have_content("Logged in as zuzu")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")
  end

    scenario "visitor can not log in without username" do
      visit login_path

      click_link "Create Account"

      fill_in "Name", with: "zuzu"
      fill_in "Password", with: "meatball"
      fill_in "Password Confirm", with: "meatball"

      click_button "Create Account"

      expect(page).to have_content("Please complete requirements before creating account")
    end

    scenario "visitor can not log in without password" do
      visit login_path

      click_link "Create Account"

      fill_in "Name", with: "zuzu"
      fill_in "username", with: "zuzu_puppy"
      fill_in "Password Confirm", with: "meatball"

      click_button "Create Account"

      expect(page).to have_content("Please complete requirements before creating account")
    end
end
