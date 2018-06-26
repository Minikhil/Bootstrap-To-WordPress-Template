<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Search Results"
	
	Dim db
	Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim query: query = "select [Listings].[id], [date_listed], [date_available], [rent], [rent_for], [total_bedrooms], [available_bedrooms], [area], [locality], (count(Images.id) > 0) or [picture] as [image] " _
	                 & "from ([Listings] left join [Images] on ([Listings].[id] = [Images].[listing_id])) " _
	                 & "where [status] = 'Active' "
	
	Dim conditions: conditions = ""
	
	Dim rent_min: rent_min = Replace(Param("rent_min"), "$", "")
	if (rent_min <> "") then
		conditions = conditions & (" and [rent] >= " & rent_min)
	end if
	
	Dim rent_max: rent_max = Replace(Param("rent_max"), "$", "")
	if (rent_max <> "") then
		conditions = conditions & (" and [rent] <= " & rent_max)
	end if
	
	Dim bedrooms_available: bedrooms_available = Param("bedrooms_available")
	if (bedrooms_available <> "") then
		conditions = conditions & (" and [available_bedrooms] >= " & bedrooms_available)
	end if
	
	Dim unit_type: unit_type = Param("unit_type")
	if (unit_type <> "") then
		conditions = conditions & (" and ([unit_type_id] =" & unit_type & ")")
		'conditions = conditions & (" and ([unit_type_id] =1)")
	end if
	
	Dim area: area = Param("area")
	if (area <> "") then
		conditions = conditions & (" and ([locality] ='" & area & "' or [area] = '" & area & "')")
	end if
	
	Dim street: street = Param("street")
	if (street <> "") then
		conditions = conditions & (" and [street] ='" & street & "'")
	end if
	
	Dim feature
	for each feature in Request.QueryString("features")
		query = query & (" and [" & MySQLEscape(feature) & "] = true")
	next
	
	query = query & conditions & (" group by [Listings].[id], [date_listed], [date_available], [rent], [rent_for], [total_bedrooms], [available_bedrooms], [area], [locality], [picture]" _
                  & " order by [date_listed] desc")
	
	Dim listings
	Set listings = Server.CreateObject ("adodb.recordset")
	listings.Open query, db, 0, 1
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Search Results</h2>
			<div id='listings'>
				<div class='headings'>
					<span class='rent'>Rent</span>
					<span class='bedrooms_total'>Bedrooms</span>
					<span class='bedrooms_available'>(Open)</span>
					<span class='date_available'>Available</span>
					<span class='area'>Area</span>
					<span class='picture'>&nbsp;</span>
				</div>
<%
	Dim prev_date_listed
	Dim date_listed
	Dim even
	Dim neighborhood
	
	do until listings.eof
		neighborhood = ""
		
		if (not isNull(listings("area"))) then
			if (listings("area") <> listings("locality")) then
				neighborhood = " (" & listings("area") & ")"
			end if
		end if
		
		date_listed = StripDate(listings("date_listed")) 'Remove any extraneous time info from the date'
		if (date_listed <> prev_date_listed) then
			prev_date_listed = date_listed
			even = false
%>
				<div class='date_listed'>Listed <%= date_listed %></div>
<%		end if %>
				<div class='listing <%= iif(even, "even", "odd") %>'>
					<a href='listing.asp?id=<%= listings("id") %>'>
						<span class='rent'>$<%= listings("rent") %></span>
						<span class='bedrooms_total'><%= listings("total_bedrooms") %></span>
						<span class='bedrooms_available'><%= listings("available_bedrooms") %></span>
						<span class='date_available'><%= listings("date_available") %></span>
						<span class='area'><%= listings("locality") & neighborhood %></span>
						<span class='picture'><%= iif(listings("image"), "Pic", "&nbsp;")%></span>
					</a>
				</div>
<%
		even = (not even)
		listings.MoveNext
	loop
%>
			</div>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>

<%
	listings.Close: Set listings = Nothing
	db.Close: Set db = Nothing
%>