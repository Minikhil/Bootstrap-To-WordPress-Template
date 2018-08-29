<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Listing Details"
	
	dim id: id = Param("id")
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim query: query = "select *" _
					 & "from [Listings] " _
					 & "where [Listings].[id] = " & id
	
	Dim listing_rs: Set listing_rs = Server.CreateObject ("adodb.recordset")
	listing_rs.Open query, db
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Flag Listing</h2>
			
			<form action="flag.asp?id=<%= id %>" method="POST" accept-charset="utf-8">
				<div class='field textarea'>
					<label for='reason'>Reason for Flagging</label>
					<textarea name="reason" id='reason' rows="6" cols="30"></textarea>
				</div>
				
				<div class='field submit'>
					<input type="submit" value="Flag Listing" id="submit">
				</div>
			</form>
			
			<p><a href='listing.asp?id=<%= id %>'>&laquo; Back to listing</a></p>
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