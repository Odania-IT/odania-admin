require 'rails_helper'

RSpec.describe AdminController, :type => :controller do
	before do
		$consul_mock.service.services = {
			'odania_static' => [
				OpenStruct.new({
										'Node' => 'agent-one',
										'Address' => '172.20.20.1',
										'ServiceID' => 'static_content_1',
										'ServiceName' => 'static-content',
										'ServiceTags' => [],
										'ServicePort' => 80,
										'ServiceAddress' => '172.20.20.1'
									}),
				OpenStruct.new({
										'Node' => 'agent-two',
										'Address' => '172.20.20.2',
										'ServiceID' => 'consul',
										'ServiceName' => 'consul',
										'ServiceTags' => [],
										'ServicePort' => 80,
										'ServiceAddress' => '172.20.20.1'
									})
			]
		}
	end

	describe "GET index" do
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

end
