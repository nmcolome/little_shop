require 'rails_helper'

RSpec.describe Admin do
  it "admin role can be created" do
    user = create(:user, role: 1)

    expect(user.role).to eq("admin")
  end
end
