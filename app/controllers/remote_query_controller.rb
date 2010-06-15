class RemoteQueryController < ApplicationController
	#include amazon helpers
	include Amazon::AWS
	include Amazon::AWS::Search

	# GET /remote_query/:search 
	# Searches Amazon's Product API for results using the keyword in :search
	# Returns a list of the first 6 results or ["None"]
	def index

		# Prepare Search
		is = ItemSearch.new( 'All', { 'Keywords' => params[:query] } )

		# 'Large' required for images 
		#  Could also be 'Small'' for just title & product group
		rg = ResponseGroup.new( 'Large' )

		# Perform the Search
		req = Request.new
		resp = req.search( is, rg ) 

		results = []
		resp["item_search_response"][0].items[0].item.each do |i|
			# Grab the attributes we want
			title = i.item_attributes.title[0].to_s[0,60]
			group = i.item_attributes.product_group.to_s
			image = amazon_image_set(i.image_sets[0].image_set)

			# Add to results array
			results << { :title => title, :group => group, :image => image }
		end

		# Return results 0-5 as JSON
		render :json => results[0..5]

		# If no results, Amazon::AWS throughs an error, so we can rescue
		# TODO There's definitely a better way to handle this
		rescue 
			render :json => ["None"]
	end

	private

	# Helper function, only argument is an image_set
	# Returns the thumbnail_image url or ""
	# Instead of thumbnail_image, could be small_image, large_image
	def amazon_image_set(set)
		set[0].thumbnail_image.url.to_s
		rescue
		 ""
	end

end
