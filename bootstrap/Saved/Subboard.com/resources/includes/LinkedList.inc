<%
	'REQUIRES: Iterator'
	
	Class LinkedList
		Private datum_
		Private next_
		
		Private Sub class_initialize
			datum_= Null
			Set next_ = Nothing
		End Sub
		
		Public Function init (datum, nxt)
			datum_ = datum
			Set next_ = nxt
		End Function
		
		Public Default Property Get data (index)
			if index = 0 then
				data = datum_
			else
				if IsNull(next_) then
					data = null
				else
					data = next_(index - 1)
				end if
			end if
		End Property
		
		Public Property Let data (index, val)
			if index = 0 then
				datum_ = val
			else
				if IsNull(next_) then
					next_.data(index - 1) = val
				else
					data = next_.data(index - 1)
				end if
			end if
		End Property
		
		Public Function push (val)
			Dim nxt: Set nxt = new LinkedList
			nxt.init datum_, next_
			datum_ = val
			Set next_ = nxt
		End Function
	End Class
%>