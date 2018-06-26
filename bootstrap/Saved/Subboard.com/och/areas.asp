<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Areas"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim areas: Set areas = Server.CreateObject("adodb.recordset")
	areas.Open "select * from areas order by name", db
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Areas</h2>
			
<%	do until areas.eof %>
			<div class='area'>
				<h3 id='<%= IdentifierCase(areas("name")) %>'><%= areas("name") %></h3>
				<img src='/och/resources/images/area_images/<%= IdentifierCase(areas("name")) %>.jpg'> 
				<%= areas("description") %>
			</div>
<%	areas.MoveNext: loop %>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
			
			<ul>
<%	areas.MoveFirst: do until areas.eof %>
				<li><a href='#<%= IdentifierCase(areas("name")) %>'><%= areas("name") %></a></li>
<%	areas.MoveNext: loop %>
			</ul>
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>