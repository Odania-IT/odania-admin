require 'rails_helper'

RSpec.describe Admin::PreviewController, :type => :controller do

	describe "GET index" do
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "GET show" do
		it "returns http success" do
			get :show, {uri: 'http://test.odania.com'}
			expect(response).to have_http_status(:success)
		end
	end

end
