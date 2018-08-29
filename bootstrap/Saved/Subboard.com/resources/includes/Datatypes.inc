<%
	class StringTypeClass
		public function form_to_db (value)
			form_to_db = value
		end function
		
		public function db_to_form (value)
			db_to_form = value
		end function
	end class
	
	class BooleanTypeClass
		public function form_to_db (value)
			form_to_db = (value <> "")
		end function
		
		public function db_to_form (value)
			db_to_form = value
		end function
	end class
	
	class TimeTypeClass
		public function form_to_db (value)
			form_to_db = FormatDateTime(value, vbShortTime)
		end function
		
		public function db_to_form (value)
			db_to_form = value
		end function
	end class
	
	Dim StringType: Set StringType = new StringTypeClass
	Dim BooleanType: Set BooleanType = new BooleanTypeClass
	Dim TimeType: Set TimeType = new TimeTypeClass
	
	Dim DatePattern: Set DatePattern = new RegExp
	DatePattern.Pattern = "(\d{2})-(\d{2})-(\d{4})"
	
	Dim TimePattern: Set TimePattern = new RegExp
	TimePattern.Pattern = "(\d{2}):(\d{2}) ([AP]M)"
%>