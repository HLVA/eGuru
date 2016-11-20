// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cable
//= require turbolinks
//= require tether
//= require bootstrap
//= require underscore
//= require gmaps/google
//= require_tree .


// $(".nav li a").on("click", function(){
//    $(".nav").find(".active").removeClass("active");
//    $(this).parent().addClass("active");
// });


function getPosition(address, callback){
	var geocoding  = new google.maps.Geocoder();
  // var address = $("#search_box_geocoding").val();
  	var position = new google.maps.LatLng(0, 0);
	if(address.length > 0){
	geocoding.geocode({'address': address},function(results, status){
			if(status == google.maps.GeocoderStatus.OK){

				position = results[0].geometry.location;	
				callback(position);

			} else {
				return false;

			}
		});
	} else {			
		return false;
	}	
};


function setMap(){
	getPosition('Vincom B, Lê Thánh Tôn, Bến Nghé, Ho Chi Minh, Vietnam', function(position){

			handler = Gmaps.build('Google');
			handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
			  markers = handler.addMarkers([
			    {
			      "lat": position.lat(),
			      "lng": position.lng(),
			      "infowindow": "hello!"
			    }
			  ]);
			  handler.bounds.extendWith(markers);
			  handler.getMap().setCenter(position);
			  handler.getMap().setZoom(15);
			  // handler.fitMapToBounds();
			});
		}
	);
};

