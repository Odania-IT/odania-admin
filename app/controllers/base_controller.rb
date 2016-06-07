class BaseController < ApplicationController
	def health
		render plain: 'OK'
	end
end
