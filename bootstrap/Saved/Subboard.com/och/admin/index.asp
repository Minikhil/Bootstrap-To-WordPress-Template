<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Search"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories_admin.inc -->
		
		<div id='content'>
			<h2>Search</h2>
			
			<form id='admin_search' action='search.asp'>
				<div class='field'>
					<label for='street_number'>Number</label>
					<input type='input' name='street_number' id='street_number'>
				</div>
				
				<div class='field'>
					<label for='street'>Street</label>
					<input type='input' name='street' id='street'>
				</div>
				
				<div class='field'>
					<label for='contact_name'>Contact Name</label>
					<input type='input' name='contact_name' id='contact_name'>
				</div>
				
				<fieldset class='checkboxes'>
<%	Dim status: for each status in status_array %>
					<div class='field checkbox'>
						<input type='checkbox' name='status-<%= status %>' value='true' id='status-<%= status %>' checked=''>
						<label for='status-<%= status %>'><%= status %></label>
					</div>
<%	next %>
				</fieldset>
				
				<div class='field'>
					<button type='submit'>Search</button>
				</div>
			</form>
		</div>
		
		<div id='secondary'>
			
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>