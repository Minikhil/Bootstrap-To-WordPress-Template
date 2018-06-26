<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<!-- #include virtual=/och/resources/includes/form_lib.inc -->
<!-- #include virtual='/och/resources/scripts/upload.asp' -->

<%
	category = "Edit"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Mode = 3
	db.Open DB_PATH
	
	Dim unit_types: Set unit_types = Server.CreateObject("adodb.recordset")
	unit_types.Open "select * from [UnitTypes]", db
	
	Dim streets: Set streets = Server.CreateObject ("adodb.recordset")
	streets.Open "select * from [Streets] order by [street]", db
	
	Dim areas: Set areas = Server.CreateObject ("adodb.recordset")
	areas.Open "select * from [Areas] order by [name]", db
	
	Dim localities: Set localities = Server.CreateObject ("adodb.recordset")
	localities.Open "select distinct name from [Localities] order by [name]", db
	
	
	
	Dim id: id = Param("id")
	
	Dim fields
	Dim auxiliary_fields_array: auxiliary_fields_array = Array("status", "date_listed")
	
	Dim errors: Set errors = CreateObject("Scripting.Dictionary")
	Dim warnings: Set warnings = CreateObject("Scripting.Dictionary")
	Dim warn: warn = false
	Dim success: success = (id <> "")
	
	Dim post: post = (Request.ServerVariables("REQUEST_METHOD") = "POST")
	if success and post then
		
		Set fields = CreateObject("Scripting.Dictionary")
		Dim field
		for each field in fields_array
			fields.Add field, Request.Form(field)
		next
		for each field in occupancy_array
			fields.Add field, (Request.Form(field) <> "")
		next
		for each field in features_array
			fields.Add field, (Request.Form(field) <> "")
		next
		for each field in safety_checklist_array
			fields.Add field, (Request.Form(field) <> "")
		next
		for each field in mandated_array
			fields.Add field, (Request.Form(field) <> "")
		next
		for each field in auxiliary_fields_array
			fields.Add field, Request.Form(field)
		next
		
		success = Validate
		CheckForWarnings
	end if
	
	if success and post then
		Dim query: query = "update [Listings] set "
		Dim values: values = ""
		
		
		for each field in fields_array
			if fields(field) = "" then
				query = query & ("[" & field & "] = null, ")
			else
				query = query & ("[" & field & "] = '" & MySQLEscape(fields(field)) & "', ")
			end if
		next
		
		for each field in occupancy_array
			query = query & ("[" & field & "] = " & LCase(fields(field)) & ", ")
		next
		
		for each field in features_array
			query = query & ("[" & field & "] = " & LCase(fields(field)) & ", ")
		next
		
		for each field in mandated_array
			query = query & ("[" & field & "] = " & LCase(fields(field)) & ", ")
		next
		
		for each field in safety_checklist_array
			query = query & ("[" & field & "] = " & LCase(fields(field)) & ", ")
		next
		
		query = query & ("[status] = '" & fields("status") & "', [date_listed] = '" & fields("date_listed") & "'")
		
		query = query & (" where [id] = " & id)
		
		db.Execute query
	end if
	
	if success then
		Set fields = Server.CreateObject("adodb.recordset")
		fields.Open "select * from Listings where id = " & id, db
	end if
	
	
	Function Validate
		Dim phone_pattern: Set phone_pattern = New RegExp: phone_pattern.pattern = "^\d\d\d-\d\d\d-\d\d\d\d$"
		Dim date_pattern: Set date_pattern = New RegExp: date_pattern.pattern = "^\d\d?[-/]\d\d?[-/]\d\d\d\d$"
		
		Validate = true
		
		Validate = Validate and ValidateNumeric("unit_type_id")
		
		Validate = Validate and ValidateNumeric("total_bedrooms")
		Validate = Validate and ValidateRequired("total_bedrooms")
		
		Validate = Validate and ValidateNumeric("available_bedrooms")
		Validate = Validate and ValidateRequired("available_bedrooms")
		
		Validate = Validate and ValidateEnum("lease", Array("Yes", "No", "Negotiable"))
		
		Validate = Validate and ValidateNumeric("rent")
		Validate = Validate and ValidateRequired("rent")
		
		Validate = Validate and ValidateNumeric("security_deposit")
		Validate = Validate and ValidateRequired("security_deposit")
		
		Validate = Validate and ValidateNumeric("term")
		
		Validate = Validate and ValidateFormat("date_available", date_pattern)
		Validate = Validate and ValidateRequired("date_available")
		
		Validate = Validate and ValidateRequired("street_number")
		
		Validate = Validate and ValidateRequired("street")
		
		Validate = Validate and ValidateNumeric("postal_code")
		
		Validate = Validate and ValidateRequired("contact_name")
	End Function
	
	Function CheckForWarnings
		Dim phone_pattern: Set phone_pattern = New RegExp: phone_pattern.pattern = "^\d\d\d-\d\d\d-\d\d\d\d$"
		
		if fields("postal_code") = "" then
			Warning "postal_code", "should be present for all new listings."
		else
			Dim check: Set check = Server.CreateObject("adodb.recordset")
			
			check.Open "select * from [Localities] where [postal_code] = " & fields("postal_code") & " and [name] = '" & fields("locality") & "'", db
			if check.eof then
				Warning "locality", "is not associated with that postal code"
			end if
			check.Close
			
			if fields("area") <> "" then
				check.Open "select * from [Areas_PostalCodes] inner join [Areas] on [Areas_PostalCodes].[area_id] = [Areas].[id] " & _
				           "where [postal_code] = " & fields("postal_code") & " and [name] = '" & fields("area") & "'", db
				
				if check.eof then
					Warning "area", "is not associated with that postal code"
				end if
				
				check.Close
			end if
			
			Set check = Nothing
		end if
		
		if not phone_pattern.test(fields("primary_phone")) then
			Warning "primary_phone", "is not formatted like a new listing."
		end if
		
		if not phone_pattern.test(fields("secondary_phone")) then
			Warning "secondary_phone", "is not formatted like a new listing."
		end if
	End Function
	
	Function Warning (field, message)
		if warnings.Exists(field) then
			warnings.Items(field) = message
		else
			warnings.Add field, message
		end if
		warn = true
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
			<h2>Edit Listing</h2>
			
			<form action='edit.asp?id=<%= id %>' method='post'>
				
				<% if post then %><p>The changes were<%= iif(success, " ", " not ") %>applied.</p><% end if %>
				
<%	if not success then %>
				<h4>Errors</h4>
				<dl class='errors'>
<%		Dim f: for each f in errors.Keys %>
					<dt><%= Humanize(f) %></dt>
					<dd><%= errors(f) %></dd>
<%		next %>
				</dl>
<%	end if %>
<%	if warn then %>
				<h4>Notices</h4>
				<dl class='warnings'>
<%		for each f in warnings.Keys %>
					<dt><%= Humanize(f) %></dt>
					<dd><%= warnings(f) %></dd>
<%		next %>
				</dl>
<%	end if %>
				<fieldset>
					<h3>Administrative</h3>
<%	if fields("status") = "ApartmentComplex" then %>
					<div class='field'>
						<label>Status</label>
						<input type='text' name='status' value='Apartment Complex' disabled=''>
					</div>
<%	else %>
					<div class='field select'>
						<label for='status'>Status</label>
						<select id='status' name='status'>
<%		Dim status: for each status in status_array %>
							<option <%= iif(fields("status") = status, "selected = 'selected'", "") %>><%= status %></option>
<%		next %>
						</select>
					</div>
<%	end if %>
					
					<% TextField "date_listed" %>
				</fieldset>
				
				<fieldset>
					<h3>Unit Information</h3>
					
					<div class='field select'>
						<label for='unit_type'>Unit Type</label>
						<select id='unit_type' name='unit_type_id'>
<%	do until unit_types.eof %>
							<option value='<%= unit_types("id") %>' <% if fields("unit_type_id") = unit_types("id") then print "selected='selected'" end if %>><%= unit_types("unit_type") %></option>
<%	unit_types.MoveNext: loop %>
						</select>
					</div>
					
					<% TextField "available_bedrooms" %>
					
					<% TextField "total_bedrooms" %>
					
					<fieldset class='radios'>
						<div class='legend'>Lease</div>
						<%
							Dim value: for each value in Array("Yes", "No", "Negotiable")
								RadioButton "lease", value, value = "No"
							next
						%>
					</fieldset>
					
					<% TextField "rent" %>
			
					<% RadioButtons "rent_for", Array("per room", "for entire unit"), "per room" %>
					
					<% TextField "security_deposit" %>
					
					<% TextField "term" %>
					
					<% TextField "date_available" %>
					
					<div class='field'>
						<label for='comments'>Comments</label>
						<textarea rows='3' cols='40' id='comments' name='comments'><%= HTMLEscape(fields("comments")) %></textarea>
					</div>
					
					<!-- <fieldset class='radios'>
						<div class='legend'>Preferred Gender</div>
						
						<div class='field radio'>
							<label for='preferred_gender-any'>Any</label>
							<input type='radio' name='preferred_gender' id-'preferred_gender-any' <%= iif(fields("preferred_gender") = "", "checked=''", "") %>>
						</div>
						<% RadioButton "preferred_gender", "Male", fields("preferred_gender") = "Male" %>
						<% RadioButton "preferred_gender", "Female", fields("preferred_gender") = "Female" %>
					</fieldset> -->
				</fieldset>
				
				<fieldset>
					<h3>Unit Location</h3>
					
					<% TextField "street_number" %>
					
					<% TextField "street" %>
					
					<% TextField "apartment_number" %>
					
					<% TextField "postal_code" %>
					
					<div class='field select'>
						<label for='locality'>Locality</label>
						<select id='locality' name='locality'>
<%	do until localities.eof %>
							<option <% if fields("locality") = localities("name") then print "selected='selected'" end if %>><%= localities("name") %></option>
<%	localities.MoveNext: loop %>
						</select>
					</div>
					
					<div class='field select'>
						<label for='area'>Area</label>
						<select id='area' name='area'>
							<option value=''>None</option>
<%	do until areas.eof %>
							<option <% if fields("area") = areas("name") then print "selected='selected'" end if %>><%= areas("name") %></option>
<%	areas.MoveNext: loop %>
						</select>
					</div>
				</fieldset>
				
				<fieldset>
					<h3>Rent Includes</h3>
					
					<% Checkboxes features_array %>
				</fieldset>
				
				<fieldset>
					<h3>Certificate of Occupancy</h3>
					
					<% Checkboxes occupancy_array %>
				</fieldset>
				
				<fieldset>
					<h3>Mandated Checklist</h3>
					
					<% Checkboxes mandated_array %>
				</fieldset>
				
				<fieldset class='safety'>
					<h3>Safety Checklist</h3>
					
					<% Checkboxes safety_checklist_array %>
				</fieldset>
				
				<fieldset>
					<h3>Contact</h3>
					
					<% TextField "contact_name" %>
					
					<% RadioButtons "contact", Array("Landlord seeking tenants", "Tenant seeking roommates"), "Landlord seeking tenants" %>
					
					<% TextField "primary_phone" %>
					
					<div class='sample'>Ex: 716-555-1729</div>
					
					<% TextField "secondary_phone" %>
					
					<% TextField "best_time_to_call" %>
					
					<% TextField "email" %>
				</fieldset>
				
				<h3>Images</h3>
				<p>The images for this listing should go in the following directory: <code>W:\och\resources\images\listing_images\<%= id %></code> and be named <code>1</code>, <code>2</code>, or <code>3.jpg</code>.</p>
				
				<input type='submit' value='Submit'>
			</form>
		</div>
		
		<div id='secondary'>
			<ul>
				<li><a href='listing.asp?id=<%= id %>'>Back to listing</a></li>
			</ul>
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>