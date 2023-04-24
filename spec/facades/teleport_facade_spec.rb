require "rails_helper"

describe "Teleport Facade", :vcr do
	let(:facade) { TeleportFacade.new }

	it "returns all salaries for specific jobs" do
		salaries = facade.get_salaries("denver")

	end
end