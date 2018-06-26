<%
	Option Explicit
	
	'Convenience Constants'
	
	Dim METHOD: METHOD = Request.ServerVariables("REQUEST_METHOD")
	Dim LF: LF = VBLF
	
	'Legacy functions'
	
	Dim category, subcategory
	Sub Current(this, link)
		If this = link Then
			Print("class='current'")
		End If
	End Sub
	
	'General functions'
	
	Function iif(expression, truepart, falsepart)
		If expression = true Then 
			iif = truepart
		Else
			iif = falsepart
		End If
	End Function
	
	Function iff(expression, truepart)
		iff = iif(expression, truepart, "")
	End Function
	
	Function print(text)
		Response.Write(text)
	End Function
	
	Function include(path)
		Server.Execute(path)
	End Function
	
	Function GetPage(url)
		Dim agent: Set agent = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		agent.open "GET", "http://localhost" & url, False
		agent.send
		GetPage = agent.responseText
	End Function
	
	Function get_page_cached(url, freshness)
		Dim location, query_string
		Dim qpos: qpos = InStrRev(url, "?")
		if qpos = 0 then
			query_String = "&"
			location = url
		else
			query_string = Mid(url, qpos + 1):
			location = Left(url, qpos - 1)
		end if
		
		Dim fs: Set fs = Server.CreateObject("Scripting.FileSystemObject")
		Dim cache_path: cache_path = Server.MapPath(location & ".cached/" & query_string)
		
		Dim hit: hit = false
		Dim stream
		if fs.FileExists(cache_path) then
			Dim cache: Set cache = fs.GetFile(cache_path)
			Dim last_cached: last_cached = cache.DateLastModified
			Dim cache_cutoff: cache_cutoff = DateAdd(Right(freshness, 1), -1 * CInt(Left(freshness, Len(freshness) - 1)), now)
			
			if last_cached >= cache_cutoff then
				hit = true
				Set stream = cache.OpenAsTextStream(1, -1)
			else
				Set stream = cache.OpenAsTextStream(2, -1)
			end if
		else
			Set stream = fs.CreateTextFile(cache_path, false, true)
		end if
		
		if hit then
			print stream.ReadAll
		else
			Dim agent: Set agent = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
			agent.Open "GET", "http://localhost" & url, False
			agent.Send
			print agent.ResponseText
			
			stream.Write agent.ResponseText
		end if
		
		stream.Close
	End Function
	
	'String functions'
	
	Function SentenceCase(str)
		SentenceCase = UCase(Left(str, 1)) & LCase(Mid(str, 2))
	End Function
	
	Function IdentifierCase(str)
		IdentifierCase = Replace(LCase(str), " ", "_")
		IdentifierCase = Replace(IdentifierCase, "/", "-")
	End Function
	
	Function Humanize(identifier)
		Dim words: words = Split(identifier, "_")
		Dim i: for i = 0 to UBound(words)
			words(i) = SentenceCase(words(i))
		next
		Humanize = Join(words, " ")
	End Function
	
	'Numeric functions'
	
	Function round_up(n)
		Round_Up = -1 * (Int(-1 * n))
	End Function
	
	Function pad_int(n, width)
		Dim i: for i = 1 to width
			n = "0" & n
		next
		pad_int = Right(n, width)
	End Function
	
	'Date functions'
	Function date_to_http (date)
		date = DateAdd("h", 5, date) 'GMT'
		Dim parts(5), time(2)
		
		time(0) = pad_int(Hour(date), 2)
		time(1) = pad_int(Minute(date), 2)
		time(2) = pad_int(Second(date), 2)
		
		parts(0) = weekday_name(Weekday(date), true) & ","
		parts(1) = pad_int(Day(date), 2)
		parts(2) = month_name(Month(date), true)
		parts(3) = Year(date)
		parts(4) = Join(time, ":")
		parts(5) = "GMT"
		
		date_to_http = Join(parts)
	End Function
	
	Function date_from_http (date)
		Dim re: Set re = new RegExp
		re.Pattern = "\w\w\w, (\d\d) (\w\w\w) (\d\d\d\d) (\d\d:\d\d:\d\d) GMT"
		date_from_http = DateAdd("h", -5, CDate(re.Replace(date, "$2 $1, $3 $4")))
	End Function
%>

<!-- #include virtual=/resources/includes/LinkedList.inc -->