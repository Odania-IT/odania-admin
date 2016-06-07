require 'rails_helper'

RSpec.describe Admin::PreviewController, :type => :controller do
	before do
		allow_any_instance_of(VarnishConcern).to receive(:get_from_varnish).and_return('This is our simple dummy template from varnish!!')
	end

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
