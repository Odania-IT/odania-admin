class Admin::ElasticsearchController < AdminController
	#skip_before_action :verify_authenticity_token, only: :show

	def index
		@idx_type = 'web'.eql?(params[:idx_type]) ? 'web' : 'partial'
		@valid_sizes = [25, 50, 100, 250, 1000]
		@current_index = 'web'.eql?(@idx_type) ? $web_index : $partial_index
		@size = @valid_sizes.include?(params[:size].to_i) ? params[:size].to_i : 25
		@from = params[:from].to_i

		result = $elasticsearch.search index: @current_index, type: @idx_type, body: {
			from: @from,
			size: @size,
			sort: {
				_score: 'desc'
			}
		}

		@hit_result = result['hits']
		@total_hits = @hit_result['total']
		@hits = @hit_result['hits']
	end

	def show
		idx_type = 'web'.eql?(params[:idx_type]) ? 'web' : 'partial'
		partial_name = params[:partial_name]
		result = $elasticsearch.search index: @current_index, type: idx_type, body: {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: {
				bool: {
					must: [
						{term: {partial_name: partial_name}}
					]
				}
			}
		}


		@hit_result = result['hits']
		@total_hits = @hit_result['total']
		@hits = @hit_result['hits']
	end
end
