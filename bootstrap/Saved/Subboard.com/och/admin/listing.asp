<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Listing Details"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim highlight_status: highlight_status = (Param("highlight_status") <> "")
	Dim id: id = Param("id")
	Dim query: query = "select * from [Listings]  where [Listings].[id] = " & id
	
	Dim listing_rs: Set listing_rs = Server.CreateObject ("adodb.recordset")
	listing_rs.Open query, db
	
	Dim unit_type_rs: Set unit_type_rs = Server.CreateObject ("adodb.recordset")
	unit_type_rs.Open "select * from [UnitTypes] where [id] = " & listing_rs("unit_type_id"), db
	Dim unit_type: unit_type = unit_type_rs("unit_type")
	
	Dim listing_image_paths(): ReDim listing_image_paths(ALLOWED_IMAGES)
	Dim listing_images: Set listing_images = Server.CreateObject("adodb.recordset")
	listing_images.Open "select * from [Images] where [listing_id] = " & Param("id"), db
	
	Dim i: for i = 1 to ALLOWED_IMAGES
		if not listing_images.eof then
			listing_image_paths(i) = "/och/resources/images/listing_images/" & listing_images("id") & ".jpg"
			listing_images.MoveNext
		else
			listing_image_paths(i) = ""
		end if
	next
	
	Dim locality_area_rs: Set locality_area_rs = Server.CreateObject("adodb.recordset")
	locality_area_rs.Open "select * from [Areas] where [name] = '" & listing_rs("locality") & "'", db
	
	Dim locality_area: locality_area = ""
	if not locality_area_rs.eof then
		locality_area = locality_area_rs("name")
	end if
	
	locality_area_rs.Close: Set locality_area_rs = Nothing
	
	Function listing(param)
		if param = "unit_type" then
			listing = unit_type
		elseif param = "area" then
			listing = iif(listing_rs("area") <> "", listing_rs("area"), locality_area)
		else
			listing = listing_rs(param)
		end if
	End Function
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories_admin.inc -->
		
		<div id='content'>
			<!-- #include virtual='/och/resources/includes/listing.inc' -->
		</div>
		
		<div id='secondary'>
			<div>Status: <%= iif(highlight_status, "<strong>" & listing("status") & "</strong>", listing("status")) %></div>
			<ul>
				<% if listing("status") <> "Active" then %><li><a href='set_status.asp?status=Active&amp;id=<%= id %>'>Activate</a></li><% end if %>
				<% if listing("status") <> "Inactive" then %><li><a href='set_status.asp?status=Inactive&amp;id=<%= id %>'>Make Inactive</a></li><% end if %>
				<% if listing("status") <> "Pending" then %><li><a href='set_status.asp?status=Pending&amp;id=<%= id %>'>Make Pending</a></li><% end if %>
			</ul>
			<ul>
				<li><a href='edit.asp?id=<%= id %>'>Edit this listing</a></li>
				<li><a href='delete.asp?id=<%= id %>'>Delete this listing</a></li>
				<li><a href='search.asp?status-Pending=true&amp;status-Active=true&amp;status-Expired=true&amp;contact_name=<%= Server.URLEncode(listing("contact_name")) %>'>Find listings by this landlord</a></li>
				<li><a href='search.asp?status-Pending=true&amp;status-Active=true&amp;status-Expired=true&amp;street_number=<%= Server.URLEncode(listing("street_number")) %>&amp;street=<%= Server.URLEncode(listing("street")) %>'>Find listings of this address</a></li>
			</ul>
			<ul>
				<li><a href='/och/resources/scripts/send_activation_mail.pl?id=<%= id %>'>Send activation email</a></li>
			</ul>
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>

<%
	listing_rs.Close: Set listing_rs = Nothing
	db.Close: Set db = Nothing
%>