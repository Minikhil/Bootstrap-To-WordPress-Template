' An alias for Response.Write.
' 
' Just here to save a few keystrokes and to reduce visual clutter. Why VBScript
' needs 14 characters just to print, I'll never know.
' 
' @param str: The string to be printed.
function print (str)
	dim slash:  slash = inStr(0, str, "\", 0)
	
	if slash = 0 then
		Response.write str
		exit function
	end if
	
	dim start:  start = 1
	dim length: length = len(str)
	
	do while slash > 0
		Response.write mid(str, start, slash - start)
		
		select case mid(str, slash + 1, 1)
			case "\": Response.write "\"
			case "'": Response.write """"
			case "n": Response.write VBLF
			case "r": Response.write VBCR
			case "t": Response.write VBTAB
		end select
		
		start = slash + 2
		slash = inStr(start, str, "\", 0)
	loop
	
	Response.write right(str, length - start + 1)
end function

function sprint (str)
	dim slash:  slash = inStr(0, str, "\", 0)
	
	if slash = 0 then
		sprint = str
		exit function
	end if
	
	dim start:  start = 1
	dim length: length = len(str)
	dim sb: set sb = StringBuilder.new
	
	do while slash > 0
		sb.add mid(str, start, slash - start)
		
		select case mid(str, slash + 1, 1)
			case "\": sb.add "\"
			case "'": sb.add """"
			case "n": sb.add VBLF
			case "r": sb.add VBCR
			case "t": sb.add VBTAB
		end select
		
		start = slash + 2
		slash = inStr(start, str, "\", 0)
	loop
	
	sb.add right(str, length - start + 1)
	
	sprint = sb.string
end function