// Base URL to send request to
var search_controller_route = '/remote/'

// Function that makes AJAX request, builds list, then shows it
function get_recommendations() {
	$.getJSON(search_controller_route+$('#product_search').val(), function (data) {
		if(data[0] == "None") { //Shortcut for when there are no results
			$('#results_list').text('No results found');
		} else {
			list = "<ol>";
			$.each(data, function(i, value) { // Build List
				list += "<li class='result'><a href='javascript:void(0)'>"+value.title+"</a>"
				list += '<img class="result_img" src="'+value.image+'"</li>';
			});
			list += "</ol>";
			$('#results_list').html(list);
		}
	});

}

var timeout; // Variable to hold timeout 
$(document).ready(function () {

	// Monitor product_search input for typing
	$('#product_search').bind('keyup', function() {
		$('#results_list').text('Loading..');

		// Don't send request until user has stopped typing for 900ms
		clearTimeout(timeout); 
		timeout = setTimeout(get_recommendations, 900);
	});
});


