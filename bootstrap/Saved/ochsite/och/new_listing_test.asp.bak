<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<!-- #include virtual='/och/resources/scripts/upload.asp' -->

<%
	category = "Create New Listing"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim unit_types: Set unit_types = Server.CreateObject("adodb.recordset")
	unit_types.Open "select * from [UnitTypes]", db
	
	Dim streets: Set streets = Server.CreateObject ("adodb.recordset")
	streets.Open "select * from [Streets] order by [street]", db
	
	Dim valid1: valid1 = false 'Is stage 1 data valid?
	Dim valid2: valid2 = false 'Is stage 2 data valid?
	Dim errors: Set errors = CreateObject("Scripting.Dictionary")
	
	Dim fields: Set fields = CreateObject("Scripting.Dictionary")
	Dim listing_images(): ReDim listing_images(ALLOWED_IMAGES)
	Dim listing_image_paths(): ReDim listing_image_paths(ALLOWED_IMAGES)

	Dim auxiliary_fields_array: auxiliary_fields_array = Array("mode", "temp_id")
	
	Dim post: post = (Request.ServerVariables("REQUEST_METHOD") = "POST")
	Dim mode: mode = "stage1" 'stage1 | stage2 | preview | confirm | dupe'
	
	Dim uploader
	
	Dim listing_id
	
	if post then
		Set uploader = new FileUploader
		uploader.Upload()
		
		Dim field
		for each field in fields_array
			fields.Add field, uploader.Form(field)
		next
		for each field in features_array
			fields.Add field, (uploader.Form(field) <> "")
		next
		for each field in safety_checklist_array
			fields.Add field, (uploader.Form(field) <> "")
		next
		for each field in auxiliary_fields_array
			fields.Add field, uploader.Form(field)
		next
		
		fields("rent") = Replace(fields("rent"), "$", "")
		fields("security_deposit") = Replace(fields("security_deposit"), "$", "")
		
		Dim temp_id: Set temp_id = Server.CreateObject("adodb.recordset")
		Dim dupe: dupe = false
		if (fields("temp_id") = Empty) then
			db.execute "insert into [TempIDs] ([submitted]) values (false)"
			
			temp_id.Open "select @@identity", db
			fields("temp_id") = temp_id(0).Value
		else
			temp_id.Open "select * from [TempIDs] where id = " & MySQLEscape(fields("temp_id")), db
			dupe = temp_id("submitted")
		end if
		
		valid1 = Validate1
		valid2 = Validate2
		
		Dim file_system: Set file_system = Server.CreateObject("Scripting.FileSystemObject")
		Dim temp_path: temp_path = "/och/resources/images/temp_images/" & fields("temp_id") & "/"
		
		Dim i: for i = 1 to ALLOWED_IMAGES
			listing_image_paths(i) = Empty
			Dim listing_image_name: listing_image_name = i & ".jpg"
			
			if uploader.Files.Exists("image" & i) & uploader.Form("image" & i) <> "" then
				Set listing_images(i) = uploader.Files("image" & i)
				if ValidateImage(listing_images(i)) then
					listing_images(i).FileName = listing_image_name
					
					if not file_system.FolderExists(server_root_path & temp_path) then
						file_system.CreateFolder(server_root_path & temp_path)
					end if
					
					listing_images(i).SaveToDisk(server_root_path & temp_path)
					listing_image_paths(i) = temp_path & listing_image_name
				else
					valid2 = false
				end if
			else
				if file_system.FileExists(server_root_path & temp_path & listing_image_name) then
					listing_image_paths(i) = temp_path & listing_image_name
				end if
			end if
		next
		
		'IE does buttons wrong; this adjusts for it.'
		'Update: Okay, IE6 does them wronger, so now they''re inputs. So this is redundant. Meh.'
		Select Case fields("mode")
			Case "Step 1"
				mode = "stage1"
			Case "Step 2"
				mode = "stage2"
			Case "Preview"
				mode = "preview"
			Case "Confirm"
				mode = "confirm"
			Case Else
				mode = fields("mode")
		End Select
		
		if dupe then
			mode = "dupe"
		elseif not valid1 then
			mode = "stage1"
		elseif (mode <> "stage1") and not valid2 then
			mode = "stage2"
		end if
	end if
	
	if mode = "confirm" then
		fields("area") = Replace(fields("area"), "none", "")
		fields("preferred_gender") = Replace(fields("preferred_gender"), "on", "")
		
		Dim query: query = "insert into [Listings] ("
		Dim values: values = ""
		
		for each field in fields_array
			if fields(field) <> Empty then
				query = query & ("[" & field & "], ")
				values = values & ("'" & MySQLEscape(fields(field)) & "', ")
			end if
		next
		
		for each field in features_array
			query = query & ("[" & field & "], ")
			values = values & (iif(fields(field), "true", "false") & ", ")
		next
		
		for each field in safety_checklist_array
			query = query & ("[" & field & "], ")
			values = values & (iif(fields(field), "true", "false") & ", ")
		next
		
		query = query & "[status], [date_listed]) values (" & values & "'Pending', #" & FormatDateTime(Now(), 2) & "#)"
		
		db.Execute query
		
		query = "update [TempIDs] set [submitted] = true where [id] = " & fields("temp_id")
		db.Execute query
		
		Dim created: Set created = Server.CreateObject("adodb.recordset")
		created.Open "select @@identity", db
		listing_id = created(0).Value
		
		created.Close: Set created = Nothing
		
		for i = 1 to ALLOWED_IMAGES
			if listing_image_paths(i) <> Empty then
				db.execute "insert into [Images] ([listing_id]) values (" & listing_id & ")"
				
				Dim listing_image: Set listing_image = Server.CreateObject("adodb.recordset")
				listing_image.Open "select @@identity", db
				Dim image_id: image_id = listing_image(0)
				
				file_system.CopyFile (server_root_path & listing_image_paths(i)), (server_root_path & "/och/resources/images/listing_images/" & image_id & ".jpg")
			end if
		next
	end if
	
	Dim unit_type: Set unit_type = Server.CreateObject("adodb.recordset")
	unit_type.Open ("select * from [UnitTypes] where [id] = " & iif(fields("unit_type_id") <> "", fields("unit_type_id"), "1")), db
	unit_type = unit_type("unit_type")
	
	Dim areas: areas = Null
	Dim localities: localities = Null
	if fields("postal_code") <> Empty then
		Set areas = Server.CreateObject("adodb.recordset")
		areas.Open "select [Areas.id] as id, [Areas].[name] as name from ([Areas_PostalCodes] inner join [Areas] on [Areas_PostalCodes].[area_id] = [Areas].[id]) where [Areas_PostalCodes].[postal_code] = " & MySQLEscape(fields("postal_code")), db
		
		Set localities = Server.CreateObject("adodb.recordset")
		localities.Open "select * from [Localities] where postal_code = " & MySQLEscape(fields("postal_code")), db, 3
	end if
	
	Dim locality_area_rs: Set locality_area_rs = Server.CreateObject("adodb.recordset")
	locality_area_rs.Open "select * from [Areas] where [name] = '" & MySQLEscape(fields("locality")) & "'", db
	
	Dim locality_area: locality_area = ""
	if not locality_area_rs.eof then
		locality_area = locality_area_rs("name")
	end if
	
	locality_area_rs.Close: Set locality_area_rs = Nothing
	
	Function listing(field) 'Interfaces to listing.inc'
		if fields.Exists(field) then
			listing = fields(field)
		elseif field = "unit_type" then
			listing = unit_type
		elseif field = "date_listed" then
			listing = FormatDateTime(Now(), 2)
		elseif field = "area" then
			listing = iif(fields("area") <> "", fields("area"), locality_area)
		else
			listing = false
		end if
	End Function
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<style type='text/css'>
			.stage1, .stage2, .preview, .confirm, .dupe {
				display: none;
			}
			
			#stage1 .stage1, #stage2 .stage2, #preview .preview, #confirm .confirm, #dupe .dupe {
				display: block !important;
			}
		</style>
	</head>
	<body id='<%= mode %>'>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2 class='stage1'>New Listing &ndash; Step 1</h2>
			
			<h2 class='stage2'>New Listing &ndash; Step 2</h2>
			<p class='stage2'>Add more information to make your listing stand out.</p>
			
			
			<div class='preview'>
				<h2>Preview New Listing</h2>
				<p>This is a preview of how your listing will appear when it is posted.</p>
				
				<!-- #include virtual=/och/resources/includes/listing.inc -->
			</div>
			
			<div class='confirm'>
				<h2>New Listing Created</h2>
				<p>Your listing has been successfully submitted. To create another listing, return to the <a href='new_listing.asp'>beginning</a> of the form. If you would like to make changes, or when your apartment or room has been filled, please <a href='contact.asp'>contact</a> the SBI Off-Campus Housing Office.</p>
				
				<p><strong>To pay for your listing, click <a href='pay.asp?id=<%= listing_id %>'>here</a></strong>.</p>
					
				<p>Please write down your listing ID if you wish to <a href='advertise.asp'>pay later</a>: <strong><%= listing_id %></strong></p>
			</div>
			
			<h2 class='dupe'>Duplicate Listing</h2>
			<p class='dupe'>This listing has already been submitted. To create another listing, return to the <a href='new_listing.asp'>beginning</a> of the form.</p>
			
<%	if post and (not valid1 or not valid2) then %>
			<div class='errors'>
				<p>The following errors were detected:</p>
				<ul>
<%		Dim e: for each e in errors.Keys %>
					<li><%= Humanize(e) & " " & errors.Item(e)  %></li>
<%		next %>
				</ul>
			</div>
<%	end if %>

			<!-- #include virtual=/och/resources/includes/listing_form_test.inc -->
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>

<%
	if not isNull(areas) then
		areas.Close: Set areas = Nothing
	end if
	
	if not isNull(localities) then
		localities.Close: Set localities = Nothing
	end if
	
	unit_types.Close: Set unit_types = Nothing
	streets.Close: Set streets = Nothing
	db.Close: Set db = Nothing
%>