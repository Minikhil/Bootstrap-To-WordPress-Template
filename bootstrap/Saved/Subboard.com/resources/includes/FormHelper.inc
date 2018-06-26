<!-- #include file='Fields.inc' -->

<%
	'REQUIRES: List, Iterator'
	
	class FormHelper
		private fields_
		private valid_
		private errors_
		
		private sub CLASS_INITIALIZE
			valid_ = true
			Set errors_ = new List
			Set fields_ = Server.CreateObject("scripting.dictionary")
		end sub
		
		public Default property Get field (name)
			Set field = fields_(name)
		end property
		
		public property Get valid
			valid = valid_
		end property
		
		public property Get error_iterator
			Set error_iterator = errors_.iterator
		end property
		
		public property Get iterator
			Dim itr: Set itr = new ArrayIterator
			itr.init fields_.items
			Set iterator = itr
		end property
		
		public function error (message)
			valid_ = false
			errors_.Add(message)
		end function
		
		'============================================================================'
		
		public function add_field (name, f)
			f.init me, name
			fields_.Add name, f
		end function
		
		public function text_field (name)
			Dim f: Set f = new TextField
			add_field name, f
			Set text_field = f
		end function
		
		public function text_area_field (name)
			Dim f: Set f = new TextAreaField
			add_field name, f
			Set text_area_field = f
		end function
		
		public function checkbox_field (name)
			Dim f: Set f = new CheckboxField
			add_field name, f
			Set checkbox_field = f
		end function
		
		public function select_field (name, iterator)
			Dim f: Set f = new SelectField
			Set f.iterator = iterator
			add_field name, f
			Set select_field = f
		end function
		
	end class

	class FormQuery
		private columns_, placeholders_
		private arguments_
		private prefix_
		
		public function init (prefix, form)
			prefix_= prefix
			
			Set arguments_ = new List
			Dim form_itr: Set form_itr = form.iterator
			Dim is_first: is_first = true
			
			do while form_itr.has_next
				with form_itr.get_next
					if not .virtual then
						if is_first then
							is_first = false
							placeholders_  = "?"
						else
							columns_ = columns_ & ", "
							placeholders_ = placeholders_ & ", ?"
						end if
						columns_ = columns_ & ("[" & .name & "]")
						arguments_.add .data_type.form_to_db(.value)
					end if
				end with
			loop
		end function
		
		public property get query_string
			query_string = prefix_ & " (" & columns_ & ") values (" & placeholders_ & ");"
		end property
		
		public property get arguments
			arguments = arguments_.to_array
		end property
	end class
%>
