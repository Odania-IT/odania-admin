class Admin::PreviewController < AdminController
	include VarnishConcern

	skip_before_action :verify_authenticity_token, only: :show

	def index
		global_config = Odania.plugin.get_global_config
		@plugin_config = Odania.plugin.plugin_config.load_global_config global_config
	end

	def show
		@uri = URI.parse params[:uri]
		@result = get_from_varnish @uri

		html_doc = Nokogiri::HTML(@result)

		prepare_preview_link html_doc, 'a', 'href'
		prepare_preview_link html_doc, 'script', 'src'
		prepare_preview_link html_doc, 'link', 'href'
		prepare_preview_link html_doc, 'img', 'src'

		uri_string = @uri.to_s
		if uri_string.end_with? 'js'
			return render js: @result
		elsif uri_string.end_with? 'css'
			return render text: @result, content_type: 'text/css'
		elsif uri_string.end_with? 'png'
			return send_data @result, type: MIME::Types.type_for('image.png').first.content_type, disposition: 'inline'
		elsif uri_string.end_with? 'jpg'
			return send_data @result, type: MIME::Types.type_for('image.jpg').first.content_type, disposition: 'inline'
		elsif uri_string.end_with? 'gif'
			return send_data @result, type: MIME::Types.type_for('image.gif').first.content_type, disposition: 'inline'
		end

		render html: html_doc.to_xhtml(indent: 3).html_safe
	end

	private

	def prepare_preview_link(html_doc, type, href_name)
		html_doc.css(type).each do |element|
			href = element[href_name]

			unless href.nil?
				if href.start_with? 'http'
					target_uri = URI.parse(href)
					next unless @uri.host.eql? target_uri.host
					href = target_uri.path
				end

				if href.start_with? '//'
					target_uri = URI.parse("http:#{href}")
					href = target_uri.path
				end

				href = "/#{href}" unless href.nil? or href.start_with? '/'
				element[href_name] = admin_preview_show_path(uri: "http://#{@uri.host}#{href}")
			end
		end
	end

end
