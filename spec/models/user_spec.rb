require 'rails_helper'

RSpec.describe User do
  it "has all required fields" do
    user = User.create(username: "Squeemish",
                      first_name: "Squee",
                      last_name: "Leigh",
                      email: "Squee@squee.com",
                      password: "Squee",
                      address: "1 Squee Lane",
                      city: "Squeevillia",
                      state: "Squeeorado",
                      zipcode: '80206',
                      role: 0)

    expect(user.username).to eq("Squeemish")
    expect(user.first_name).to eq("Squee")
    expect(user.last_name).to eq("Leigh")
    expect(user.email).to eq("Squee@squee.com")
    expect(user.password).to eq("Squee")
    expect(user.address).to eq("1 Squee Lane")
    expect(user.city).to eq("Squeevillia")
    expect(user.state).to eq("Squeeorado")
    expect(user.zipcode).to eq("80206")
    expect(user.role).to eq("default")
  end

  context "has all of the necessary attributes" do
    it "must have a username" do
      user = User.create(first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
      role: 0)

      expect(user).to be_invalid
    end

    it "must have a first_name" do
      user = User.create(username: "Squeemish",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a last_name" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a email" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a password" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a address" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a city" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        state: "Squeeorado",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a state" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        zipcode: '80206',
                        role: 0)

      expect(user).to be_invalid
    end

    it "must have a zipcode" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        role: 0)

      expect(user).to be_invalid
    end

    it "user role defaults to default" do
      user = User.create(username: "Squeemish",
                        first_name: "Squee",
                        last_name: "Leigh",
                        email: "Squee@squee.com",
                        password: "Squee",
                        address: "1 Squee Lane",
                        city: "Squeevillia",
                        state: "Squeeorado",
                        zipcode: '80206')

      expect(user.role).to eq("default")
    end
  end

  context "attributes are unique when necessary" do
    xit "user must have an original username" do
      user = create(:user)
      user2 = create(:user, username: user.username)

      expect(user2).to be_invalid
    end

    xit "user must have an original email" do
      user = create(:user)
      user2 = create(:user, email: user.email)

      expect(user2).to be_invalid
    end
  end
end
