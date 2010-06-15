class RemoteQueryController < ApplicationController
	include Amazon::AWS
	include Amazon::AWS::Search
	skip_filter :log_pageview
	def index

		is = ItemSearch.new( 'All', { 'Keywords' => params[:query] } )
		rg = ResponseGroup.new( 'Large' )
		req = Request.new

		resp = req.search( is, rg ) 

		x = []
		y = ""
		resp["item_search_response"][0].items[0].item.each do |i|
			title = i.item_attributes.title[0].to_s[0,60]
			group = i.item_attributes.product_group.to_s
			image = amazon_image_set(i.image_sets[0].image_set)

			x << { :title => title, :group => group, :image => image }
		end
		render :json => x[0..5]

		rescue 
			render :json => ["None"]
	end

	private

	def amazon_image_set(set)
		set[0].thumbnail_image.url.to_s
		rescue
		 ""
	end

end
