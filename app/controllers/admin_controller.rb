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

			puts health_state.inspect
			puts service_id
			puts service_name

			@services[service_name][service_id][:checks] << health_state
		end

		logger.info '####'
		logger.info @services.inspect
	end
end
