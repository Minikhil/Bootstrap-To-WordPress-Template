<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Search Results"
	
	dim db: set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	dim query: query = "select id, contact_name, email, primary_phone, secondary_phone, street_number, street, locality from Listings where status = 'Active' order by contact_name, email, primary_phone, secondary_phone;"
	
	dim landlords: set landlords = Server.CreateObject("adodb.recordset")
	landlords.Open query, db, 3
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<style type='text/css'>
			.even {
				background: #ddd;
			}
			
			.landlord .contact {
				clear: left;
				font-weight: bold;
			}
			
			.landlord .contact div {
				float: left;
			}
			
			.landlord .contact .contact_name {
				width: 30%;
				margin-left: 2%;
			}
			
			.landlord .contact .email {
				width: 35%;
			}
			
			.landlord .contact .primary_phone, .secondary_phone {
				width: 15%;
			}
			
			.landlord .listings .listing {
				clear: both;
				margin-left: 2em;
			}
		</style>
		
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories_admin.inc -->
		
		<div id='content'>
			<h2>List of Landlords</h2>
			
			<div id='landlords'>
<%
	Dim even
	dim contact_name, email, primary_phone, secondary_phone
	
	function is_current
		is_current = (strcomp(contact_name, landlords("contact_name"), 1) = 0) and _
					 (strcomp(email, landlords("email"), 1) = 0) and _
					 (primary_phone = landlords("primary_phone")) and _
					 (secondary_phone = landlords("secondary_phone"))
	end function
	
	do until landlords.eof
		contact_name = landlords("contact_name")
		email = landlords("email")
		primary_phone = landlords("primary_phone")
		secondary_phone = landlords("secondary_phone")
%>
				<div class='landlord <%= iif(even, "even", "odd") %>'>
					<div class='contact'>
						<div class='contact_name'><%= contact_name %></div>
						<div class='email'><%= iif(email <> "", email, "&nbsp;") %></div>
						<div class='primary_phone'><%= iif(primary_phone <> "", primary_phone, "&nbsp;") %></div>
						<div class='secondary_phone'><%= iif(secondary_phone <> "", secondary_phone, "&nbsp;") %></div>
					</div>
					
					<div class='listings'>
<%
			do while not landlords.eof
				if not is_current then exit do
%>
						<div class='listing'>
							<div class='address'><a href='listing.asp?id=<%= landlords("id") %>'><%= landlords("street_number") & " " & landlords("street") & ", " & landlords("locality") %></a></div>
						</div>
<%
				landlords.moveNext
			loop
%>
					</div>
				</div>
<%
		even = (not even):
	loop
%>
			</div>
		</div>
		
		<div id='secondary'>
			
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>