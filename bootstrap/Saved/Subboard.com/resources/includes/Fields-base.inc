<%
		private form_ 'The form to which the field belongs'
		
		private name_ 'The name of the field, used for the HTML name and id'
		private type_ 'HTML type'
		private label_ 'HTML label, defaults to humanized name'
		private html_ 'The HTML code'
		
		private value_ 'The value held by the field, taken from Request.Form'
		private data_type_ 'Data type'
		private valid_ 'Has not failed validation'
		private virtual_ 'Does not participate in query building'
		
		public property get name
			name = name_
		end property
		
		public property get value
			value = value_
		end property
		
		public property let value (val)
			value_ = val
		end property
		
		public property get label
			label = label_
		end property
		
		public property let label (val)
			label_= val
		end property
		
		public property get tipe
			tipe = type_
		end property
		
		public property get data_type
			Set data_type = data_type_
		end property
		
		public property set data_type (val)
			Set data_type_ = val
		end property
		
		public property get virtual
			virtual = virtual_
		end property
		
		public property let virtual (val)
			virtual_ = val
		end property
		
		public function init (form, name)
			Set form_ = form
			name_ = name
			label_ = humanize(name)
			value_ = iif(isEmpty(Request.Form(name)), "", Request.Form(name))
			valid_ = true
			virtual_= false
		end function
		
		'============================================================================'
		
		public function print_field
			print "<div class='field " & type_ & "'>"
			print "<label for='" & name_ & "'>" & label_ & "</label>"
			
			print_field_body
			
			print "</div>"
		end function
		
		public default property get html
			if isEmpty(html_) then
				create_html
			end if
			html = html_
		end property
		
		private function create_html
			html_ = ("<div class='field " & type_ & iff(METHOD = "POST" and not valid_, " invalid") & "'>") & ("<label for='" & name_ & "'>" & label_ & "</label>")
			html_ = html_ & body_html
			html_ = html_ & "</div>"
		end function
		
		'============================================================================'
		
		private function error (message)
			valid_= false
			form_.error(message)
		end function
		
		public function is_format (re, message)
			if not re.Test(value_) then
				error(message)
			end if
		end function
		
		public function is_date
			is_format DatePattern, Humanize(name_) & " should be in the format MM-DD-YYYY."
		end function
		
		public function is_time
			is_format TimePattern, Humanize(name_) & " should be in the format HH:MM followed by AM or PM."
			Set data_type_ = TimeType
		end function
%>