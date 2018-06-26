<%
	class RSIterator
		private rs
		private field
		
		public sub init (myrs, myfield)
			Set rs = myrs
			field = myfield
		end sub
		
		public function hasNext
			hasNext = not rs.EOF
		end function
		
		public function getNext
			getNext = rs(field)
			rs.MoveNext
		end function
	end class
	
	class ArrayIterator
		private array
		private length
		private i
		
		public sub init (myarray, mylength)
			array = myarray
			length = mylength
			i = 0
		end sub
	end class
	
	class ArrayList
		private length
		private data()
		private size
		
		private INIT_SIZE
		private ENLARGE_FACTOR
		private SHRINK_FACTOR
		private SHRINK_THRESHOLD
		
		private sub CLASS_INITIALIZE
			INIT_SIZE = 8
			ENLARGE_FACTOR = 2
			SHRINK_FACTOR = 1.5
			SHRINK_THRESHOLD = 2
			
			length = 0
			ReDim data(INIT_SIZE)
			size = 8
		end sub
		
		public Default property Get item (i)
			item = data(i)
		end property
		
		public property Let item (i, val)
			data(i) = val
		end property
		
		public property Set item (i, val)
			Set data(i) = val
		end property
		
		public function add (e)
			if (length >= size) then
				size = size * ENLARGE_FACTOR
				ReDim Preserve data(size)
			end if
			data(length) = e
			length = length + 1
		end function
		
		public function iterator
			Dim itr
			Set itr = new ArrayIterator
			itr.Init data, length
			iterator = itr
		end function
	end class
	
	class FormHelper
		private myFields
		private myFieldsValid
		private myValid
		private myErrors
		
		private sub CLASS_INITIALIZE
			Set myFields = Server.CreateObject("scripting.dictionary")
			Set myFieldsValid = Server.CreateObject("scripting.dictionary")
			myValid = true
			Set myErrors = new ArrayList
		end sub
		
		public Default property Get fields (field)
			fields = myFields(field)
		end property
		
		public property Let fields (field, val)
			myFields(field) = val
		end property
		
		public function add (field, val)
			myFields.add field, val
			myFieldsValid.add field, val
		end function
		
		public property Get errors
			errors = myErrors
		end property
		
		public function Error (message)
			myValid = false
			myErrors.Add(message)
		end function
		
		'============================================================================'
		
		private function BeginField (tipe, name)
			print "<div class='field " & tipe & "'>"
		end function
		
		private function EndField
			print "</div>"
		end function
		
		private function Label (name, str)
			print "<label for='" & name & "'>" & str & "</label>"
		end function
		
		private function ValidClass (name)
			ValidClass = iif(myFieldsValid(name), "", "invalid")
		end function
		
		public function Text (name, str)
			BeginField "text", name
			Label name, str
			
			print "<input type='text' name='" & name & "' id='" & name
			if myFields(name) <> "" then
				print "' value='" & myFields(name)
			end if
			print "'>"
			
			endField
		end function
		
		public function Checkbox (name, str)
			BeginField "checkbox", name
			Label name, str
			
			print "<input type='checkbox' name='" & name & "' id='" & name
			if myFields(name) <> "" then
				print "' checked='"
			end if
			print "'>"
			
			endField
		end function
		
		public function SelectField (name, str, itr)
			BeginField "select", name
			Label name, str
			
			print "<select id='" & name & "' name='" & name & "'>"
			do while itr.hasNext
				print "<option>"
				print itr.getNext
				print "</option>"
			loop
			print "</select>"
			
			endField
		end function
		
		public function Textarea (name, str)
			BeginField "textarea", name
			Label name, str
			
			print "<textarea id='" & name & "' name='" & name & "'>"
			print myFields(name)
			print "</textarea>"
			
			endField
		end function
		
		'============================================================================'
		
		public function ValidateFormat(name, re)
			if re.Test(myFields(name)) then
				ValidateFormat = true
			else
				myValid = false
				ValidateFormat = false
			end if
		end function
	end class
	
	class TextField
		private name_
		private value_
		private label_
		private type_
		
		private sub CLASS_INITIALIZE
			type_ = "text"
		end sub
		
		public property get name
			name = name_
		end property
		
		public property get value
			value = value_
		end property
		
		public property get label
			label = label_
		end property
		
		public property set label (new_label)
			label_= new_label
		end property
		
		public function print
			begin_field type_, name_
			print_label name_, label_
			
			print "<input type='" & type_ & "' name='" & name & "' id='" & name
			if myFields(name) <> "" then
				print "' value='" & myFields(name)
			end if
			print "'>"
			
			endField
		end function
		
		private function begin_field (tipe, name)
			print "<div class='field " & tipe & "'>"
		end function
		
		private function end_field
			print "</div>"
		end function
		
		private function print_label (name, str)
			print "<label for='" & name & "'>" & str & "</label>"
		end function
		
		private function print_value
			
		end function
	end class
%>