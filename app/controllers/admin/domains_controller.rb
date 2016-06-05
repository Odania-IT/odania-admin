class Admin::DomainsController < AdminController
	def index
		global_config = Odania.plugin.get_global_config
		@plugin_config = Odania.plugin.plugin_config.load_global_config global_config
	end
end
