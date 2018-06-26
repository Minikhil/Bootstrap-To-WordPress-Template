<%
	'REQUIRES: Iterator'
	
	Const LIST_MIN_ARRAY_SIZE = 10
	Const LIST_MAX_HEAD_ROOM = 2.25
	Const LIST_GRANTED_HEAD_ROOM = 1.5	
	
	Class List
		Private mySize
		Private myData
		Private arraySize
		
		Private Sub class_initialize
			mySize = 0
			arraySize = LIST_MIN_ARRAY_SIZE
			myData = Array()
			ReDim myData(LIST_MIN_ARRAY_SIZE - 1)
		End Sub
		
		Public Property Get size
			size = mySize
		End ProPerty
		
		Public Function to_array
			Dim a
			Redim a(mySize - 1)
			Dim i: i = 0
			do while (i < mySize)
				if IsObject(myData(i)) then
					Set a(i) = myData(i)
				else
					a(i) = myData(i)
				end if
				i = i + 1
			loop
			to_array = a
		End Function
		
		Public Default Property Get data(index)
			data = iif(index_is_valid(index), myData(index), null)
		End Property
		
		Public Property Let data(index, value)
			if index_is_valid(index) then
				myData(index) = value
			end if
		End Property
		
		Public Property Set data(index, value)
			if index_is_valid(index) then
				Set myData(index) = value
			end if
		End Property
		
		Public Function Iterator
			Dim itr
			Set itr = new ArrayIterator
			itr.init myData
			itr.length = mySize
			Set Iterator = itr
		End Function
		
		Public Function add(datum)
			mySize = mySize + 1
			if (mySize > arraySize) then
				expand_array
			end if
			if IsObject(datum) then
				Set myData(mySize - 1) = datum
			else
				myData(mySize - 1) = datum
			end if
			
			add = datum
		End Function
		
		Public Function remove(index)
			Dim return
			if index_is_valid(index) then
				return = myData(index)
				
				mySize = mySize - 1
				Dim i
				for i = index to (mySize - 1)
					myData(i) = myData(i + 1)
				next
				
				if (Max(Round_Up(mySize  * LIST_MAX_HEAD_ROOM), 10) < arraySize) then
					shrink_array
				end if
				
				remove = return
			else
				return = null
			end if
		End Function
		
		Private Function expand_array
			arraySize = Round_Up(arraySize * LIST_GRANTED_HEAD_ROOM)
			ReDim Preserve myData(arraySize - 1)
		End Function
		
		Private Function shrink_array
			arraySize = Max(Round_Up(mySize * LIST_GRANTED_HEAD_ROOM), 10)
			ReDim Preserve myData(arraySize - 1)
		End Function
		
		'VBscript doesn''t have any of those fancy "exceptions", so this basically bails if anything goes wrong.'
		Private Function index_is_valid(index)
			if ((Int(index) <> index) or (index < 0) or (index >= size)) then
				index_is_valid = false
				Err.Raise 8
				Err.Description = "Invalid list index."
				Err.Source = "List Class"
			else
				index_is_valid = true
			end if
		End Function
	End Class
%>