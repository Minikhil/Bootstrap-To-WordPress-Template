<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Listing Details"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim query: query = "select *" _
	                 & "from [Listings] " _
	                 & "where [Listings].[id] = " & Param("id")
	
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
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<!-- #include virtual='/och/resources/includes/listing.inc' -->
			
			<p class='disclaimer'>The SBI Off-Campus Housing Office does not investigate, inspect, endorse, or guarantee the accuracy of the information provided in any listing, the condition of the accommodation, or the suitability or performance of either the lister or any prospective tenant. Sub-Board I, Inc. or the University at Buffalo shall not be responsible for any loss or damage suffered or incurred by any individual or entity arising out of or relating to the listings. Sub-Board I, Inc. or the University at Buffalo shall not be deemed to be a party, and shall have no responsibility or obligation to enforce such agreement.</p>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>

<%
	listing_rs.Close: Set listing_rs = Nothing
	db.Close: Set db = Nothing
%>