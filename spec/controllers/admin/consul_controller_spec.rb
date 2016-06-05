require 'rails_helper'

RSpec.describe Admin::ConsulController, :type => :controller do

	describe "GET index" do
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET service" do
		it "returns http success" do
			get :service
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET status" do
		it "returns http success" do
			get :status
			expect(response).to have_http_status(:success)
		end
	end

end
