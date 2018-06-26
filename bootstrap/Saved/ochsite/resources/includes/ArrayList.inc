<!-- #include virtual='/resources/includes/Iterator.inc' -->

<%
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
%>