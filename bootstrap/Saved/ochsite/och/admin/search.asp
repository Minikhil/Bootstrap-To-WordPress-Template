<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Search Results"
	
	Dim db
	Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim query: query = "select [id], [street_number], [street], [contact_name], [date_listed], [status] from [Listings] where true"
	Dim query_string: query_string = "Showing "
	
	Dim street_number: street_number = Param("street_number")
	Dim street: street = Param("street")
	Dim contact_name: contact_name = Param("contact_name")
	
	if street_number = "" and street = "" and contact_name = "" then
		query_string = query_string + "all "
	end if
	
	Dim statuses: statuses = "false"
	Dim num_statuses: num_statuses = 0
	Dim selected_statuses(3)
	if Param("status-active") <> "" then
		statuses = statuses & " or [status] = 'Active'"
		selected_statuses(num_statuses) = "active"
		num_statuses = num_statuses + 1
	end if
	if Param("status-pending") <> "" then
		statuses = statuses & " or [status] = 'Pending'"
		selected_statuses(num_statuses) = "pending"
		num_statuses = num_statuses + 1
	end if
	if Param("status-inactive") <> "" then
		statuses = statuses & " or [status] = 'Inactive'"
		selected_statuses(num_statuses) = "inactive"
		num_statuses = num_statuses + 1
	end if
	query = query & " and (" & statuses & ")"
	
	select case num_statuses
		case 1
			query_string = query_string + selected_statuses(0)
		case 2
			query_string = query_string + (selected_statuses(0) + " and " + selected_statuses(1))
	end select
	
	query_string = query_string + " listings"
	
	if (street_number <> "") then
		query = query & " and [street_number] = " & street_number
		if street = "" then
			query_string = query_string + (" at number " + street_number)
		else
			query_string = query_string + (" at " + street_number + " " + street)
		end if
	end if
	if (street <> "") then
		query = query & " and [street] like '%" & street & "%'"
		if street_number = "" then
			query_string = query_string + (" on " + street)
		end if
	end if
	
	if (contact_name <> "") then
		query = query & " and [contact_name] like '%" & contact_name & "%'"
		query_string = query_string + (" by " + contact_name)
	end if
	
	query = query & " order by [date_listed] desc"
	
	Dim listings
	Set listings = Server.CreateObject ("adodb.recordset")
	listings.Open query, db, 3
	
	query_string = query_string  & ". " & listings.RecordCount & " found."
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<style type='text/css'>
			#listings .street_number {
				width: 13.5%;
				padding-left: 1.5%;
			}
			
			#listings .street {
				width: 30%;
			}
			
			#listings .contact_name {
				width: 25%;
			}
			
			#listings .date_listed {
				width: 19%;
				
				font-weight: normal;
				margin-top: 0;
			}
			
			#listings .headings .date_listed {
				font-weight: bold;
			}
			
			#listings .status {
				width: 10%
			}
		</style>
		
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories_admin.inc -->
		
		<div id='content'>
			<h2>Search Results</h2>
			
			<form id='admin_search' action='search.asp'>
				<div class='field'>
					<label for='street_number'>Number</label>
					<input type='input' name='street_number' id='street_number' value='<%= street_number %>'>
				</div>
				
				<div class='field'>
					<label for='street'>Street</label>
					<input type='input' name='street' id='street' value='<%= street %>'>
				</div>
				
				<div class='field'>
					<label for='contact_name'>Contact Name</label>
					<input type='input' name='contact_name' id='contact_name' value='<%= contact_name %>'>
				</div>
				
				<fieldset class='checkboxes'>
<%	Dim status: for each status in status_array %>
					<div class='field checkbox'>
						<input type='checkbox' name='status-<%= status %>' value='true' id='status-<%= status %>' <%= iif(Param("status-" & status) = "true", "checked=''", "") %>>
						<label for='status-<%= status %>'><%= status %></label>
					</div>
<%	next %>
				</fieldset>
				
				<div class='field'>
					<button type='submit'>Search</button>
				</div>
			</form>
			
			<div><%= query_string %></div>
			<div id='listings'>
				<div class='headings'>
					<span class='street_number'>Number</span>
					<span class='street'>Street</span>
					<span class='contact_name'>Contact Name</span>
					<span class='date_listed'>Date Listed</span>
					<span class='status'>Status</span>
				</div>
<%
	Dim even
	
	do until listings.eof
%>
				<div class='listing <%= iif(even, "even", "odd") %>'>
					<a href='listing.asp?id=<%= listings("id") %>'>
						<span class='street_number'><%= listings("street_number") %></span>
						<span class='street'><%= listings("street") %></span>
						<span class='contact_name'><%= listings("contact_name") %></span>
						<span class='date_listed'><%= StripDate(listings("date_listed")) %></span>
						<span class='status'><%= listings("status") %></span>
					</a>
				</div>
<%
		even = (not even):
		listings.MoveNext:
	loop
%>
			</div>
		</div>
		
		<div id='secondary'>
			<ul>
				<li><a href='search.asp?street_number=&amp;street=&amp;contact_name=&amp;status-Pending=true&amp;status-Active=true&amp;status-Expired=true'>All listings</a></li>
				<li><a href='search.asp?street_number=&amp;street=&amp;contact_name=&amp;status-Active=true'>Active listings</a></li>
				<li><a href='search.asp?street_number=&amp;street=&amp;contact_name=&amp;status-Pending=true'>Pending listings</a></li>
				<li><a href='search.asp?street_number=&amp;street=&amp;contact_name=&amp;status-Expired=true'>Expired listings</a></li>
			</ul>
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>

<%
	listings.Close: Set listings = Nothing
	db.Close: Set db = Nothing
%>
