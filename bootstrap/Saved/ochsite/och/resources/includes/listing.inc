			<h2>Listing Details</h2>
			<dl class='listing'>
				<dt>Location</dt>
				<dd>
					<% 
						Dim apt: apt = listing("apartment_number")
						apt = iif (apt <> "", " Apt. " & apt, "")
						print HTMLEscape(listing("street_number")) & " " & HTMLEscape(listing("street")) & apt & "<br>" & listing("locality") & ", NY " & listing("postal_code") & " "
						print "<a href='/och/map.asp?listing_id=" & listing("id") & "'>Map</a>"
					%>
				</dd>
				
<%	if listing("area") <> "" then %>
				<dt><%= iif(listing("locality") = "Buffalo", "Neighborhood", "Area") %></dt>
				<dd>
					<a href='/och/areas.asp#<%= IdentifierCase(HTMLEscape(listing("area"))) %>'><%= HTMLEscape(listing("area")) %></a>
				</dd>
<%	end if %>
				
				<dt>Unit Type</dt>
				<dd><%= HTMLEscape(listing("unit_type")) %></dd>
				
				<dt>Bedrooms</dt>
				<dd><%= HTMLEscape(listing("total_bedrooms")) & " total, " & HTMLEscape(listing("available_bedrooms")) & " available" %></dd>
				
				<dt>Rent</dt>
				<dd>
					<div><%= "$" & HTMLEscape(listing("rent")) & " " & listing("rent_for") & ", $" & HTMLEscape(listing("security_deposit")) & " security deposit" %></div>
				</dd>


				
				<dt>Available</dt>
				<dd><%= HTMLEscape(listing("date_available")) %></dd>


				
				<dt>Lease</dt>
				<dd><%= HTMLEscape(listing("lease")) & iif(listing("term") <> "", ", " & listing("term") & " months", "") %></dd>
				







				<dt>Includes</dt>
				<dd>
					<ul>
<%
	Dim feature
	for each feature in features_array
		if (HTMLEscape(listing(feature))) then
%>						<li><%= Humanize(feature) %></li>
<%		end if
	next
%>					</ul>
				</dd>






				


				

<dt>&nbsp;</dt>

				<dt>Certificate of Occupancy</dt>
				<dd>
					<ul class='checklist'>
<%
		Dim occupancy
		for each occupancy in occupancy_array
%>
						<li class='<%= lcase(listing(occupancy)) %>'><span class='checkmark'><%= iif(listing(occupancy), "Yes ", "No ") %></span><%= Humanize(occupancy) %></li>
<%		next %>
					</ul>
				</dd>

<dt>&nbsp;</dt>

				<dt>State/Local Mandated (<a href='/och/resources.asp#apartment_safety'>about</a>)</dt>
				<dd>
					<ul class='checklist'>
<%
		Dim mandated_item
		for each mandated_item in mandated_array
%>
						<li class='<%= lcase(listing(mandated_item)) %>'><span class='checkmark'><%= iif(listing(mandated_item), "Yes ", "No ") %></span><%= Humanize(mandated_item) %></li>
<%		next %>
					</ul>
				</dd>
				
				<dt>Extra Housing Safety Needs (<a href='/och/resources.asp#apartment_safety'>about</a>)</dt>
				<dd>
					<ul class='checklist'>
<%
		Dim safety_item
		for each safety_item in safety_checklist_array
%>
						<li class='<%= lcase(listing(safety_item)) %>'><span class='checkmark'><%= iif(listing(safety_item), "Yes ", "No ") %></span><%= Humanize(safety_item) %></li>
<%		next %>
					</ul>
				</dd>

<%	if listing("locality") = "Buffalo" and listing("contact") = "Landlord seeking tenants" then %>
				<dt>Listed on Buffalo Rental Registry<br><br></dt>
				<dd><%= iif(listing("registered_with_rental_registry"), "Yes", "No") %></dd> 
<%	end if %>

<%	if listing("comments") <> "" then %>
				<dt>Comments</dt>
				<dd><%= HTMLEscape(listing("comments")) %></dd>
<%	end if %>
				
				<dt>Contact</dt>
				<dd>
					<div><%= HTMLEscape(listing("contact_name")) %> (<%= HTMLEscape(listing("contact")) %>)</div>
<%	if listing("primary_phone") <> "" then %>
					<div>Home: <%= HTMLEscape(listing("primary_phone")) %></div><% end if %>
<%	if listing("secondary_phone") <> "" then %>
					<div>Office: <%= HTMLEscape(listing("secondary_phone")) %></div><% end if %>
<%	if listing("best_time_to_call") <> "" then %>
					<div>Best time: <%= HTMLEscape(listing("best_time_to_call")) %></div><% end if %>
<%	if listing("email") <> "" then %>
					<div><%= HTMLEscape(listing("email")) %></div><% end if %>
				</dd>
			</dl>
			
<%	if listing("picture") then %>
			<img class='listing_image' src='/sbi-och/pics/<%= listing("available_bedrooms") & "-" & listing("total_bedrooms") & "-" & listing("rent") & "-" & listing("street_number") %>.jpg'>
<%	else
		Dim im: for im = 1 to ALLOWED_IMAGES
			if listing_image_paths(im) <> Empty then
%>			<img class='listing_image' src='<%= site_url & listing_image_paths(im) %>'>
<%			end if
		next
	end if
%>
			<p>This listing will expire <%= DateAdd("d", 90, listing("date_listed")) %>.</p>