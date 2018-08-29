function createMap(element, center, zoom)
{
	var map_wrapper = document.getElementById(element);
	
	for (var i=0; i < map_wrapper.childNodes.length; i++)
	{
		map_wrapper.removeChild(map_wrapper.childNodes[i]);
	}
	
	var map = new GMap2(map_wrapper);
	
	map.addControl(new GSmallMapControl());
	map.addControl(new GMapTypeControl());
	
	if (typeof center == 'undefined') {center = NORTH_CAMPUS;}
	if (typeof zoom == 'undefined') {zoom = 14;}
	map.setCenter(center, zoom);
	
	return map;
}

function createMarkerWithText(loc, text)
{
	text = "<div class='map_info'>" + text + "</div>";
	var marker = new GMarker(loc);
	GEvent.addListener(marker, "click", function() {
		marker.openInfoWindowHtml(text);
	});
	return marker;
}

String.prototype.toTitleCase = function() {
	var spaced = this.replace("_", " ");
	var capitalized = "";
	var capitalize = true;
	for (var i = 0; i < spaced.length; i++)
	{
		if (capitalize) {
			capitalized += spaced[i].toUpperCase();
			after_space = false;
		}
		else capitalized += spaced[i];
		
		capitalize = (spaced[i] == " ");
	}
	
	return capitalized
}

var NORTH_CAMPUS      = new GLatLng(43.003  , -78.785  );
var NORTH_CAMPUS_MAIN = new GLatLng(43.001  , -78.788  );
var SOUTH_CAMPUS      = new GLatLng(42.954  , -78.818  );

var FLINT_LOOP        = new GLatLng(43.00045, -78.7892 );
var LOCKWOOD          = new GLatLng(42.99989, -78.7855 );

var SBI_HEALTH        = new GLatLng(42.9525 , -78.8199 );
var GOODYEAR          = new GLatLng(42.9568 , -78.8157 );
var MAIN_LOOP         = new GLatLng(42.954  , -78.8194 );
var DIEFENDORF_LOOP   = new GLatLng(42.95315, -78.81795);