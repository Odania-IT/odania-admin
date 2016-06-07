class AdminController < ApplicationController
	layout 'admin'

	def index
		@services = {}

		Odania.plugin.get_all.each_pair do |service_name, instances|
			instances.each do |service|
				@services[service.ServiceName] = {} if @services[service.ServiceName].nil?

				@services[service.ServiceName][service.ServiceID] = {
					:name => service.ServiceName,
					:info => service,
					:checks => []
				}
			end
		end

		Odania.plugin.health.state.each do |health_state|
			service_id = health_state['ServiceID'].empty? ? 'consul' : health_state['ServiceID']
			service_name = health_state['ServiceName'].empty? ? 'consul' : health_state['ServiceName']
			@services[service_name][service_id][:checks] << health_state
		end
	end
end
