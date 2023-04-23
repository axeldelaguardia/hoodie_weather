require "rails_helper"

describe User do
	let(:user) { create(:user) }

	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_presence_of(:password) }
	it { should have_secure_password }

	it "has attribtues" do
		expect(user).to respond_to(:email)
		expect(user).to respond_to(:password)
	end
end