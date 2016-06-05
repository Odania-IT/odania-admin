class Admin::ConfigController < AdminController
	def index
		@global_config = Odania.plugin.get_global_config

		@configs = {}
		Odania.plugin.get_all.keys.each do |plugin_name|
			config = Odania.plugin.config_for plugin_name
			@configs[plugin_name] = config unless config.nil?
		end
	end
end
