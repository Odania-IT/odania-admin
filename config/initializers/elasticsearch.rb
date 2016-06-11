config = YAML.load(ERB.new(File.read(File.join(Rails.root, 'config', 'elasticsearch.yml'))).result)
$elasticsearch = Elasticsearch::Client.new log: true, hosts: config[Rails.env]['hosts']

$web_index = 'odania_web'
$partial_index = 'odania_partials'
