<!-- #include virtual='/resources/includes/initialize.inc' -->

<%
	Dim id: id = Request.Form("id")
	Dim action: action = Request.Form("action")
	
	Dim db: Set db = server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open "c:/Inetpub/wwwroot/resources/databases/jobs.mdb"
	
	Dim query: query = "update [jobs] set [available] = " & (action = "Make Available") & " where [id] = " & id
	
	print query
	db.Execute query
	
	Response.Status = "303 See Other"
	Response.AddHeader "Location", "jobs.asp"
%>