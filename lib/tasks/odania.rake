namespace :odania do
	desc 'Register service at consul'
	task :register do
		# First check for a config in the docker volume
		settings = nil
		settings = YAML.load_file '/srv/config/settings.yml' if File.exist? '/srv/config/settings.yml'
		settings = YAML.load_file 'config/settings.yml' if settings.nil?
		domain = settings['config']['domain']
		subdomain = settings['config']['subdomain']

		plugin_config = JSON.parse File.read 'config/odania-config.json'
		plugin_config['domains'][domain] = {
			subdomain => plugin_config['domains']['ADMIN_DOMAIN']['ADMIN_SUB_DOMAIN']
		}
		plugin_config['domains'].delete('ADMIN_DOMAIN')

		ips = Odania.ips
		plugin_config['plugin-config']['ips'] = ips
		plugin_config['plugin-config']['ip'] = Odania.primary_ip(ips)
		plugin_config['plugin-config']['port'] = 3000
		plugin_config['plugin-config']['tags'] = ['core-backend']
		puts JSON.pretty_generate plugin_config

		plugin_instance_name = Odania.plugin.get_plugin_instance_name plugin_config['plugin-config']['name']
		Odania.plugin.register plugin_instance_name, plugin_config
	end
end
