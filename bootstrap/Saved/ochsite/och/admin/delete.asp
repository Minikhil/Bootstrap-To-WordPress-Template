<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<%
	dim id
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		dim db: Set db = Server.CreateObject ("adodb.connection")
		db.Provider = "Microsoft.Jet.OLEDB.4.0"
		db.Open DB_PATH
		
		id = int(Request.Form("id"))
		dim query: query = "delete from [Listings] where [id] = " & id
		
		print query
		db.Execute query
		
		Response.status = "303 See Other"
		Response.addHeader "Location", "index.asp"
	else
		id = Param("id")
	end if
%>



<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Delete listing <%= id %></h2>
			
			<p>Delete this listing? This operation is irreversible.</p>
			
			<form method='POST'>
				<div><input type='hidden' name='id' value='<%= id %>' id='id'></div>
				
				<div><input type='submit' name='submit' id='submit' value='Delete'></div>
			</form>
		</div>
		
		<div id='secondary'></div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>