<!-- #include virtual=/och/resources/includes/form_lib.inc -->

<%
	'=========================================================================================================== Validate function'
	
	Function Validate1
		Dim phone_pattern: Set phone_pattern = New RegExp: phone_pattern.pattern = "^\d\d\d-\d\d\d-\d\d\d\d$"
		Dim date_pattern: Set date_pattern = New RegExp: date_pattern.pattern = "^\d\d?-\d\d?-\d\d\d\d$"
		
		Validate1 = true
		
		Validate1 = Validate1 and ValidateNumeric("unit_type_id")
		
		Validate1 = Validate1 and ValidateNumeric("total_bedrooms")
		Validate1 = Validate1 and ValidateRequired("total_bedrooms")
		
		Validate1 = Validate1 and ValidateNumeric("available_bedrooms")
		Validate1 = Validate1 and ValidateRequired("available_bedrooms")
		
		Validate1 = Validate1 and ValidateEnum("lease", Array("Yes", "No", "Negotiable"))
		
		Validate1 = Validate1 and ValidateNumeric("rent")
		Validate1 = Validate1 and ValidateRequired("rent")
		
		Validate1 = Validate1 and ValidateNumeric("security_deposit")
		Validate1 = Validate1 and ValidateRequired("security_deposit")
		
		Validate1 = Validate1 and ValidateNumeric("term")
		
		Validate1 = Validate1 and ValidateFormat("date_available", date_pattern)
		Validate1 = Validate1 and ValidateRequired("date_available")
		
		Validate1 = Validate1 and ValidateNumeric("street_number")
		Validate1 = Validate1 and ValidateRequired("street_number")
		
		Validate1 = Validate1 and ValidateRequired("street")
		
		Validate1 = Validate1 and ValidateNumeric("postal_code")
		Validate1 = Validate1 and ValidateRequired("postal_code")
		
		Validate1 = Validate1 and ValidateRequired("contact_name")
		
		Validate1 = Validate1 and ValidateFormat("primary_phone", phone_pattern)
		
		Validate1 = Validate1 and ValidateFormat("secondary_phone", phone_pattern)
		
		Dim contact: contact = (fields("primary_phone") <> "" or fields("secondary_phone") <> "" or fields("email") <> "")
		if not contact then
			Validate1 = false
			Errors.add "", "You must provide a phone number or email address."
		end if
	End Function
	
	Function Validate2
		Validate2 = true
	End Function
	
	Function ValidateImage(image)
		ValidateImage = true
		if image.FileSize > 500000 then
			Error "image", "is too large. Maximum size is 500 kB."
			ValidateImage = false
		end if
	End Function
	
	Dim street_suffix: Set street_suffix = New RegExp
	street_suffix.pattern = "\s+(avenue|ave|av|street|st|road|rs|boulevard|blvd|place|pl|drive|dr|court|ct|circle|cir|parkway|pkwy|lane|ln|square|squ|sq)?\.?\s*$"
	
	Function MatchStreets(entry, streets_rs)
		entry = LCase(entry)
		entry = street_suffix.Replace(entry, "")
		
		Dim found: found = false
		Dim street
		do until (streets_rs.eof or found)
			street = LCase(streets_rs("street"))
			street = street_suffix.Replace(street, "")
			
			if entry = street then
				found = true
			end if
			
			streets_rs.MoveNext
		loop
		MatchStreets = found
	End Function
%>

<form id='new_listing' action='new_listing.asp' method='post' enctype='multipart/form-data'>
	<fieldset class='stage1'>
		<fieldset>
			<h3>Unit Information</h3>
			
			<div class='field select'>
				<label for='unit_type'>Unit Type</label>
				<select id='unit_type' name='unit_type_id'>
<%	do until unit_types.eof %>
					<option value='<%= unit_types("id") %>' <% if unit_type = unit_types("unit_type") then print "selected='selected'" end if %>><%= unit_types("unit_type") %></option>
<%	unit_types.MoveNext: loop %>
				</select>
			</div>
			
			<% TextField "available_bedrooms" %>
			
			<% TextField "total_bedrooms" %>
			
			<fieldset class='radios'>
				<div class='legend'>Lease</div><%
			Dim value: for each value in Array("Yes", "No", "Negotiable")
				RadioButton "lease", value, value = "No"
			next
			%></fieldset>
			
			<% TextField "rent" %>
			
			<% RadioButtons "rent_for", Array("per room", "for entire unit"), "per room" %>
			
			<% TextField "security_deposit" %>
			
			<div class='field <%= iif(errors.Exists("term"), "error", "") %>'>
				<label for='term'>Term (months)</label>
				<input id='term' type='text' name='term' value='<%= fields("term") %>'>
			</div>
			
			<% TextField "date_available" %>
			
			<div class='sample'>Ex: 07-04-2008</div>
			
			<div class='field'>
				<label for='comments'>Comments</label>
				<textarea rows='3' cols='40' id='comments' name='comments'><%= HTMLEscape(fields("comments")) %></textarea>
			</div>
			
		</fieldset>
		
		<fieldset>
			<h3>Unit Location</h3>
			
			<% TextField "street_number" %>
			
			<% TextField "street" %>
			
			<% TextField "apartment_number" %>
			
			<% TextField "postal_code" %>
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
			
			<div class='field checkbox'>
				<input type='checkbox' name='registered_with_rental_registry' value='true' id='registered_with_rental_registry' <%= iif(Empty <> fields("registered_with_rental_registry"), "checked=''", "") %>>
				<label for='registered_with_rental_registry'>Registered with <a href='http://www.city-buffalo.com/Home/City_Departments/EDPIS/RentalRegistration'>Rental Registry</a></label>
			</div>
			
			<div class='sample'>Only required by law for non&ndash;owner-occupied one- and two-family rental dwellings in the City of Buffalo.</div>
			
			<% TextField "primary_phone" %>
			
			<div class='sample'>Ex: 716-555-1729</div>
			
			<% TextField "secondary_phone" %>
			
			<% TextField "best_time_to_call" %>
			
			<% TextField "email" %>
		</fieldset>
	</fieldset>
	
	<fieldset class='stage2'>
		<fieldset>
<%	if not MatchStreets(fields("street"), streets) then %>
			<p><strong>Note:</strong> SBI Off-Campus Housing isn't familiar with the street you entered,  "<%= fields("street") %>". If you're sure that it's correct, you can disregard this notice.</p>
<%	end if %>
			
<%	if not isNull(localities) then
		if localities.eof then
			TextField("locality")
		else %>
			<div class='field select'>
				<label for='locality'>Locality</label>
				<select id='locality' name='locality'>
<%			do until localities.eof %>
					<option <% if fields("locality") = localities("name") then print "selected='selected'" end if %>><%= localities("name") %></option>
<%			localities.MoveNext: loop %>
				</select>
			</div>
<%		end if
	end if %>

<%	if not isNull(areas) then
		if not areas.eof then
			Dim first_area: first_area = true %>
		
			<fieldset class='radios'>
				Is the residence in one of the following areas?
<%			do until areas.eof: dim area: area = areas("name") %>
				<div class='field radio'>
					<label for='area-<%= IdentifierCase(area) %>'><%= area %></label>
					<input type='radio' id='area-<%= IdentifierCase(area) %>' value='<%= area %>' <% print iif(area = fields("area") or (fields("area") = "" and first_area), "checked=''", "") %> name='area'>
				</div>
<%			first_area = false: areas.MoveNext: loop %>
				<div class='field radio'>
					<label for='area-none'>None of the above</label>
					<input type='radio' name='area' value='none' id='area-none' <%= iif(fields("area") = "none", "checked=''", "") %>
				</div>
			</fieldset>
<%		end if
	end if %>
		</fieldset>
		
		<fieldset>
			<h4>Upload Images</h4>
			
			<p>Images must be less than 500 kB in size. If you receive an error message saying "Operation not allowed", then one or more of your images is probably too large.</p>
<%
	for i = 1 to ALLOWED_IMAGES
		ImageUpload(i)
	next
%>
		</fieldset>
	</fieldset>
	
	<fieldset>
		<input class='stage1 next' type='submit' name='mode' value='Step 2' id='mode-stage2'>
		
		<input class='stage2 previous' type='submit' name='mode' value='Step 1' id='mode-stage1'>
		<input class='stage2 next' type='submit' name='mode' value='Preview' id='mode-preview'>
		
		<input class='preview previous' type='submit' name='mode' value='Step 2' id='mode-stage2'>
		<input class='preview next' type='submit' name='mode' value='Confirm' id='mode-confirm'>
		<p class='preview' style='clear: both'>By clicking "Confirm", I certify that all data and information declared above is accurate and truthful the best of my knowledge.</p>
	</fieldset>
	
	<fieldset>
		<input type='hidden' name='temp_id' id='temp_id' value='<%= fields("temp_id") %>'>
	</fieldset>
</form>