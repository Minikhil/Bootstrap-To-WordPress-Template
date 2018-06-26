<%
	class RSIterator
		private rs
		private field
		
		public sub init (myrs, myfield)
			Set rs = myrs
			field = myfield
		end sub
		
		public function has_next
			has_next = not rs.EOF
		end function
		
		public function get_next
			get_next = rs(field)
			rs.MoveNext
		end function
	end class
	
	class ArrayIterator
		private array_
		private length_
		private i_
		
		public property let length (val)
			length_= val
		end property
		
		public sub init (myarray)
			array_ = myarray
			length_ = UBound(myarray) + 1
			i_ = 0
		end sub
		
		public function has_next
			has_next = (i_ < length_)
		end function
		
		public function get_next
			if IsObject(array_(i_)) then
				Set get_next = array_(i_)
			else
				get_next = array_(i_)
			end if
			i_ = i_+ 1
		end function
	end class
%>