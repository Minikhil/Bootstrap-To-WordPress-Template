<%
	Option Explicit
	
	Dim here 'The URL of the current page.'
	here = Request.ServerVariables("script_name")
	
	
	Dim server_root_path: server_root_path = "E:/Inetpub/wwwroot/subboard.com/"
	Dim site_url: site_url = "http://subboard.com"
	
	Dim division 'The name of the sub-site (e.g. SBI Health Education))'
	Dim category 'The name of the current category (e.g. Services).'
	Dim subcategory 'The name of the current subcategory (e.g. Anti-Rape Task Force), or blank if the current page does not have a subcategory.'
	
	Dim lf: Chr(10) 'Defines a constant equal to the line feed. I felt guilty calling the Chr function a gajillion times'
	
	'Works as a rudimentary ternary operator for assignment.'
	'Created by Robert Ederhardt. http://blog.throbs.net/default,date,2006-05-25.aspx'
	'@param expression: the boolean expression to test.'
	'@param truepart, falsepart: the values to return depending on the value of expression.'
	Function iif(expression, truepart, falsepart)
    	If expression = true Then 
    	    iif = truepart
    	Else
    	    iif = falsepart
    	End If
	End Function
	
	'Adds a current class if the current link points to the same  part of the site as the current page.'
	'This subroutine is called by both the category and subcategory lists.'
	'@param this: a string representing the current page. Called with the category or subcategory of the calling page.'
	'@param link: a string representing the linked page. Called with the category or subcategory of the linked page.'
	Sub Current(this, link)
		If this = link Then
			Print("class='current'")
		End If
	End Sub
	
	'Prints out a line of text. Essentially a short alias for Response.Write.'
	'@param text: the text to be printed'
	Sub Print(text)
		Response.Write(text)
	End Sub
	
	'Prints out a line of text with a line feed at the end.'
	'@param text: the text to be printed'
	Sub Println(text)
		Response.Write(text & lf)
	End Sub
	
	'Prints javascript to add the specified function to the onload handler.'
	'@param func: The name of the function to execute at page load.'
	Sub Onload(func)
%>
var oldOnload = window.onload;
window.onload = (typeof oldOnload == 'function') ? function () {oldOnload(); <% Print func %>();} : <% Print func %>;
<%
	End Sub
	
	'Formats a string so that the first character is upcased and the remainder are downcased.'
	'@param str: the string to format.'
	'@return: the formatted string'
	Function TitleCase(str)
		TitleCase = UCase(Left(str, 1)) & LCase(Mid(str, 2))
	End Function
	
	Function IdentifierCase(str)
		IdentifierCase = Replace(LCase(str), " ", "_")
		IdentifierCase = Replace(IdentifierCase, "/", "-")
	End Function
	
	Function Humanize(identifier)
		Dim words: words = Split(identifier, "_")
		Dim i: for i = 0 to UBound(words)
			words(i) = TitleCase(words(i))
		next
		Humanize = Join(words, " ")
	End Function
	
	Function MySQLEscape(str)
		str = Replace(str, "'", "''")
		str = Replace(str, """", """""")
		MySQLEscape = str
	End Function
	
	Function MySQLUnEscape(str)
		str = Replace(str, """""", """")
		MySQLUnEscape = str
	End Function
	
	Function HTMLEscape(str)
		if (isNull(str)) then
			HTMLEscape = ""
		else
			str = Replace(str, "&", "&amp;")
			str = Replace(str, "<", "&lt;")
			str = Replace(str, ">", "&gt;")
			HTMLEscape = str
		end if
	End Function
	
	Function Round_Up(n)
		Round_Up = -1 * (Int(-1 * n))
	End Function
	
	Function Max(x, y)
		Max = iif(x > y, x, y)
	End Function
	
	Function Param(name)
		Param = MySQLEscape(Request.QueryString(name))
	End Function
	
	Function StripDate(datetime)
		datetime = datetime & " "
		Dim cutoff_index
		cutoff_index = InStr(datetime, " ")
		StripDate = Left(datetime, cutoff_index - 1)
	End Function
	
	Function GetPage(url)
		Dim agent: Set agent = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		agent.open "GET", "http://localhost" & url, False
		agent.send
		GetPage = agent.responseText
	End Function
%>