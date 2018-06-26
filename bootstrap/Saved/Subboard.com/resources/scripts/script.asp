<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<%
	Dim db: Set db = Server.CreateObject("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim streets: Set streets = Server.CreateObject("adodb.recordset")
	streets.Open "select * from Streets", db
	
	Dim re: Set re = new RegExp
	re.pattern = "(.*)(street|st)?(road|rd)?(avenue|ave)?(court|ct)?(lane|ln)?(parkway|pkwy)?(boulevard|blvd)?(drive|dr)?.?"
	
	
	Dim street
	Dim matches
	do until streets.eof
		street = LCase(streets("street"))
		Set matches = re.Execute(street)
		
		print street
		
		streets.MoveNext
	loop
	
%>

success