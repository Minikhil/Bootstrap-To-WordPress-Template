<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Map"
	
	Dim listing_id
	Dim area_id
	
	On Error Resume Next
		listing_id = CLng(Param("listing_id"))
		area_id = CLng(Param("area_id"))
	On Error Goto 0
	
	Dim mode: mode = "view"
	Dim address
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	if listing_id <> "" then
		Dim listing: Set listing = Server.CreateObject("adodb.recordset")
		listing.Open "select * from [Listings] where [id] = " & listing_id, db
		
		if not listing.eof then
			mode = "listing"
			address = listing("street_number") & " " & listing("street") & ", " & iif(listing("locality") = "Canada", "Ontario, Canada", listing("locality") & ", NY")
		end if
	end if
%>


<%= "" %>
<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<script src='http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAD6xilpV0YgjWf96JdWaXihQ4VKKU3qvNhADFlc31ENQK07GAmxROHMav3wufCTbfdFcACbdegnYCdQ' type='text/javascript'></script>
		<script src='http://www.subboard.com/resources/scripts/builder.js' type='text/javascript'></script>
		
		<script type="text/javascript">
		var address = '<%= address %>';
		
		var NORTH_CAMPUS      = new GLatLng(43.003  , -78.785  );
		var NORTH_CAMPUS_ADDRESS = 'Flint Rd @43, -78.7891';
		
		var NORTH_CAMPUS_MAIN = new GLatLng(43.001  , -78.788  );
		var SOUTH_CAMPUS      = new GLatLng(42.954  , -78.818  );
		var SOUTH_CAMPUS_ADDRESS = 'Main Circle @42.9541, -78.8193';
		var SOUTH_CAMPUS_OUTLINE = [
			new GLatLng(42.9515 , -78.8252 ),
			new GLatLng(42.9493 , -78.8214 ),
			new GLatLng(42.9491 , -78.8140 ),
			new GLatLng(42.9591 , -78.8141 ),
			new GLatLng(42.9573 , -78.8188 ),
			new GLatLng(42.9515 , -78.8252 )
		];
		
		var SHUTTLE_ZONE_OUTLINE = [
			new GLatLng(42.9693, -78.8041),
			new GLatLng(42.9718, -78.8061),
			new GLatLng(42.9724, -78.8232),
			new GLatLng(42.9717, -78.8233),
			new GLatLng(42.9716, -78.8324),
			new GLatLng(42.9692, -78.8323),
			new GLatLng(42.9694, -78.8382),
			new GLatLng(42.9613, -78.8384),
			new GLatLng(42.9647, -78.8436),
			new GLatLng(42.9402, -78.8442),
			new GLatLng(42.9405, -78.8071),
			new GLatLng(42.9422, -78.8033),
			new GLatLng(42.9692, -78.8040)
		];
		
		var CAMPUS_HIGHLIGHT_COLOR = '#0000ff';
		var SHUTTLE_HIGHLIGHT_COLOR = '#77ff77';
		
		var POLYGON_BORDER_WIDTH = 3;
		var POLYGON_BORDER_OPACITY = 1;
		var POLYGON_OPACITY = 0.3;
		
		var directions_destinations = [
			{
				name: 'North Campus',
				id: 'to_north_campus',
				location: NORTH_CAMPUS
			},
			{
				name: 'South Campus',
				id: 'to_south_campus',
				location: SOUTH_CAMPUS
			}
		];
		
		var map;
		
		function toggleProperty (object, property, value1, value2) {
			object[property] = (object[property] === value1) ? value2 : value1;
		}
		
		function placeMarker (location, text) {
			var marker = new GMarker(location);
			GEvent.addListener(marker, "click", function() {
				marker.openInfoWindowHtml(text);
			});
			map.addOverlay(marker);
		}
		
		function metersToMiles(meters, precision) {
			var precision_factor = Math.pow(10, precision);
			return Math.round(meters * precision_factor / 1609.344) / precision_factor;
		}
		
		function getDirections(start, end, callback) {
			var directions = new GDirections();
			GEvent.addListener(directions, "load", function() {callback(directions);});
			directions.load('from: ' + start + ' to: ' + end, {getPolyline: true, getSteps: true});
		}
		
		function displayDirections(start_address, destination) {
			
			var route_container, showHide, polyline;
			function showHideFunction() {
				toggleProperty(route_container, 'className', "hidden", "");
				toggleProperty(showHide, 'innerHTML', "(show)", "(hide)");
				toggleProperty(polyline, 'toggleVisibility', polyline.show, polyline.hide);
				polyline.toggleVisibility();
			}
			
			getDirections(start_address, destination.location, function(directions) {
				polyline = directions.getPolyline();
				map.addOverlay(polyline);
				polyline.hide();
				
				var route = directions.getRoute(0);
				
				$(destination.id).appendChild(				
					elem('div',
						elem('h4',
							metersToMiles(route.getDistance().meters, 1) + ' miles , ' + Math.round(directions.getDuration().seconds / 60) + ' minutes ',
							'To ' + destination.name + ' ',
							showHide = elem('a', {href: 'javascript: void(0)', onclick: showHideFunction}, '(show)')
						),
						/*elem('div', {klass: 'length'},
							metersToMiles(route.getDistance().meters, 1) + ' miles , ' + Math.round(directions.getDuration().seconds / 60) + ' minutes.'
						),*/
						route_container = elem('ol', {klass: 'hidden'},
							function () {
								for (var j=0; j<route.getNumSteps(); j++) {
									var step = route.getStep(j);
									
									this.appendChild(
										elem('li',
											elemFromHTML('span', {klass: 'step'}, step.getDescriptionHtml()),
											elem('span', {klass: 'step_length'}, "(" + metersToMiles(step.getDistance().meters, 1) + " miles)")
										)
									);
								}
							}
						)
					)
				);
			});
		}
		
		function initializeMap() {
			map = new GMap2($('map'));
			map.addControl(new GLargeMapControl());
			map.addControl(new GMapTypeControl());
			map.addControl(new GOverviewMapControl());
			map.addMapType(G_PHYSICAL_MAP);
			
			map.setCenter(NORTH_CAMPUS, 13);
			
			placeMarker(new GLatLng(42.954, -78.818), 'UB South Campus');
			
			var south_polygon = new GPolygon(SOUTH_CAMPUS_OUTLINE, CAMPUS_HIGHLIGHT_COLOR, POLYGON_BORDER_WIDTH, POLYGON_BORDER_OPACITY, CAMPUS_HIGHLIGHT_COLOR, POLYGON_OPACITY);
			map.addOverlay(south_polygon);
			
			if (! $('shuttle_zone')) return;
			
			var shuttle_zone = new GPolygon(SHUTTLE_ZONE_OUTLINE, SHUTTLE_HIGHLIGHT_COLOR, POLYGON_BORDER_WIDTH, POLYGON_BORDER_OPACITY, SHUTTLE_HIGHLIGHT_COLOR, POLYGON_OPACITY);
			map.addOverlay(shuttle_zone);
			shuttle_zone.hide();
			
			var about_shuttle;
			about_shuttle = $('shuttle_zone').appendChild(
				elem('p', {style:'clear:both', klass:'hidden'},
					'Addresses within this area are less than 1.5 miles from South Campus. For information about the SBI Safety Shuttle, see the ',
					elem('a', {href:'http://www.healtheducation.buffalo.edu/safety_services/shuttle.asp'},
						'SBI Safety Services website'
					),
					'.'
				)
			);
			
			$('shuttle_zone').insertBefore(
				elem('h4',
					'SBI Safety Shuttle Zone ',
					elem('a', {href:'javascript:void(0)', onclick:function() {
						toggleProperty(this, 'innerHTML', "(show)", "(hide)");
						toggleProperty(about_shuttle, 'className', 'hidden', '');
						toggleProperty(shuttle_zone, 'toggleVisibility', shuttle_zone.show, shuttle_zone.hide);
						shuttle_zone.toggleVisibility();
					}},
						'(show)'
					)
				),
				about_shuttle
			);
		}
		
		function listing() {
/*			try {*/
				var geocoder = new GClientGeocoder();
				geocoder.getLatLng(address, function (location) {
					map.setCenter(location, 13);
					placeMarker(location, "<div id='listing_location'>" + address + "</div>");
				});
				
				for (var i=0; i<directions_destinations.length; i++) {
					displayDirections(address, directions_destinations[i]);
				}
				
/*			} catch (err) {*/
/*				map.setCenter(SOUTH_CAMPUS, 15);*/
/*			}*/
		}
		
		</script>
		
		<style type='text/css'>
			#directions {
				overflow: auto;
			}
			
			#directions h4 {
				clear: both;
				float: left;
			}
			
			#directions .length  {
				float: right;
			}
			
			#directions ol {
				clear: both;
				float: left;
			}
			
			#directions li {
				float: left;
				width: 100%;
			}
			
			#directions .step {
				display: block;
				float: left;
			}
			
			#directions .step_length {
				display: block;
				float: right;
			}
			
			#directions .length {
				font-weight: bold;
			}
		</style>
		
	</head>
	<body onload='initializeMap();listing()' onunload='GUnload()'>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Map</h2>
			
			<h3>Directions to <%= address %>
				<% if listing("area") <> "" then
					print " (<a href='areas.asp#" & IdentifierCase(listing("area")) & "'>" & listing("area") & "</a>)"
				end if %></h3>
			<div id='directions'>
				<p>(Routes will be indicated on map.)</p>
				<div id='to_south_campus'>&nbsp;</div>
				<div id='to_north_campus'>&nbsp;</div>
<% if instr("14214 14215 14216 14223 14226", listing("postal_code")) then %>
				<div id='shuttle_zone'>&nbsp;</div>
<% end if %>
				<p style='clear:both'><a href='http://maps.google.com/maps?q=<%= Server.URLEncode(address) %>' target='_blank'>See address at Google Maps</a></p>
			</div>
			
			<div id='map'>
				&nbsp;
			</div>
			
			<div class='disclaimer'>
				<p>Distances are measured to the end of Main Circle for South Campus and Flint Loop for North Campus. Depending on destination, traffic, or other conditions, distance, travel time, and route may vary.</p>
				<p>The SBI Off-Campus Housing Office does not investigate, endorse, or guarantee the accuracy of the information provided in any listing, the condition of the accommodation, or the suitability or performance of either the lister or any prospective tenant. Sub-Board I, Inc. or the University at Buffalo shall not be responsible for any loss or damage suffered or incurred by any individual or entity arising out of or relating to the listings. Sub-Board I, Inc. or the University at Buffalo shall not be deemed to be a party, and shall have no responsibility or obligation to enforce such agreement.</p>
			</div>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>