<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<%
	Dim id: id = Param("id")
	Dim status: status = Param("status")
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim query: query = "update [Listings] set [status] = '" & status & "'" & iif(status = "Active", ", [date_listed] = #" & FormatDateTime(Now(), 2) & "#", "") & " where [id] = " & id
	
	db.Execute query
	
	Response.Status = "303 See Other"
	Response.AddHeader "Location", "listing.asp?highlight_status=true&id=" & id
%>