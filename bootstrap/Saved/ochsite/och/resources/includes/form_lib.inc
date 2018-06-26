<%
	'========================================================================================================== Form field helpers'
	Sub TextField(name)
		print "<div class='field " & iif(errors.Exists(name), "error", "") & "'>"
		print "<label for='" & name & "'>" & Humanize(name) & "</label>"
		print "<input type='text' id='" & name & "' name='" & name & "' value='" & HTMLEscape(fields(name)) & "'>"
		print "</div>"
	End Sub
	
	Sub Checkbox(item)
		Dim checked: checked = iif(fields(item), " checked=''", "")
		print "<div class='field checkbox'>"
		print "<input type='checkbox' name='" & item & "' value='true' id='" & item & "'" & checked & ">"
		print "<label for='" & item & "'>" & Humanize(item) & "</label>"
		print "</div>"
	End Sub
	
	Sub Checkboxes(items)
		print "<fieldset class='checkboxes'>"
		Dim item: for each item in items
			Checkbox item
		next
		print "</fieldset>"
	End Sub
	
	Sub RadioButton(name, value, is_default)
		Dim id: id = name & "-" & IdentifierCase(value)
		print "<div class='field radio'>"
		print "<label for='" & id & "'>" & value & "</label>"
		print "<input type='radio' name='" & name & "' value='" & value & "' id='" & id & "' " & iif(fields(name) = value or (is_default and IsEmpty(fields(name))), "checked=''", "") &  ">"
		print "</div>"
	End Sub
	
	Sub RadioButtons(name, values, default)
		print "<fieldset class='radios'>"
		Dim value: for each value in values
			RadioButton name, value, value = default
		next
		print "</fieldset>"
	End Sub
	
	Sub ImageUpload(i)
		print "<div class='field'>"
		print "<label for='image" & i & "'>Image " & i & "</label>"
		print "<input id='image" & i & "' type='file' name='image" & i & "'>"
		if listing_image_paths(i) <> Empty then
			print "<img class='listing_image' src='" & site_url & listing_image_paths(i) & "'>"
			''print "<script type='text/javascript' charset='utf-8'>remove_image_button(" & i & ")</script>"
		end if
		print "</div>"
	End Sub
	
	'========================================================================================================== Validation helpers'
	
	Function ValidateNumeric(field)
		Dim intPattern: Set intPattern = New RegExp: intPattern.pattern = "^\d*$"
		
		if (intPattern.Test(fields(field))) then
			if Len(fields(field)) > 7 then
				Error field, "is too large."
				ValidateNumeric = false
			else
				ValidateNumeric = true
			end if
		else
			Error field, "must be a number."
			ValidateNumeric = false
		end if
	End Function
	
	Function ValidateFormat(field, re)
		ValidateFormat = (fields(field) = "") or re.Test(fields(field))
		if (not ValidateFormat) then
			Error field, "is incorrectly formatted."
		end if
	End Function
	
	Function ValidateEnum(field, values)
		ValidateEnum = false
		Dim value: for each value in values
			if fields(field) = value then
				ValidateEnum = true
			end if
		next
		
		if not ValidateEnum then
			Error field, " is invalid. Please reselect it."
		end if
	End Function
	
	Function ValidateRequired(field)
		ValidateRequired = fields.Item(field) <> ""
		if (not ValidateRequired) then
			Error field, "is required."
		end if
	End Function
	
	Function Error(field, message)
		if errors.Exists(field) then
			errors.Item(field) = message
		else
			errors.Add field, message
		end if
	End Function
%>