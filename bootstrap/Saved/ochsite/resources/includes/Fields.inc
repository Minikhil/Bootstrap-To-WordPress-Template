<%
	class TextField
		%><!-- #include file='Fields-base.inc' --><%
		
		private sub CLASS_INITIALIZE
			type_ = "text"
			Set data_type_ = StringType
		end sub
		
		public function print_field_body
			print "<input type='" & type_ & "' name='" & name & "' id='" & name
			if value_ <> "" then
				print "' value='" & value_
			end if
			print "'>"
		end function
		
		private function body_html
			body_html = "<input type='" & type_ & "' name='" & name & ("' id='" & name & iff(value_ <> "", "' value='" & value_) & "'>")
		end function
	end class
	
	class TextAreaField
		%><!-- #include file='Fields-base.inc' --><%
		
		private sub CLASS_INITIALIZE
			type_ = "textarea"
			Set data_type_ = StringType
		end sub
		
		public function print_field_body
			print "<textarea name='" & name & "' id='" & name & "'>"
			print value_
			print "</textarea>"
		end function
		
		private function body_html
			body_html = "<textarea name='" & name & "' id='" & (name & "'>" & value_& "</textarea>")
		end function
	end class
	
	class CheckboxField
		%><!-- #include file='Fields-base.inc' --><%
		
		private sub CLASS_INITIALIZE
			type_ = "checkbox"
			Set data_type_ = BooleanType
		end sub
		
		public function print_field_body
			print "<input type='checkbox' name='" & name & "' id='" & name & "'"
			if value_ <> "" then
				print " checked=''"
			end if
			print ">"
		end function
		
		private function body_html
			body_html = "<input type='checkbox' name='" & name & "' id='" & name & ("'" & iff(value_<> "", " checked=''") & ">")
		end function
	end class
	
	class SelectField
		%><!-- #include file='Fields-base.inc' --><%
		private iterator_
		
		public property Get iterator
			iterator = iterator_
		end property
		
		public property Set iterator (val)
			Set iterator_ = val
		end property
		
		private sub CLASS_INITIALIZE
			type_ = "select"
			Set data_type_ = StringType
		end sub
		
		public function print_field_body
			print "<select name='" & name & "' id='" & name & "'>"
			Dim current
			do while iterator_.has_next
				current = iterator_.get_next
				print "<option"
				if current = value_ then
					print " selected=''"
				end if
				print ">"
				print current
				print "</option>"
			loop
			print "</select>"
		end function
		
		private function body_html
			body_html = "<select name='" & name & "' id='" & name & "'>"
			
			Dim current
			do while iterator_.has_next
				current = iterator_.get_next
				body_html = body_html & ("<option" & iff(current = value_, " selected=''") & ">" & current & "</option>")
			loop
			body_html = body_html & "</select>"
		end function
	end class
%>