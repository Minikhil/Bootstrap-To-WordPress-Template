<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim listings: Set listings = Server.CreateObject("adodb.recordset")
	listings.Open "select * from Listings left join UnitTypes on Listings.unit_type_id = UnitTypes.id where status=""Active"";", db
	
	Dim features: features = Array("heat", "gas", "water", "electricity")
	
	Function Check(feature)
		Check = iif(listings(feature), "x", "&nbsp;")
	End Function
	
	Function ProperCase(str)
		Dim words: words = split(str, " ")
		Dim i: for i = 0 to UBound(words)
			words(i) = UCase(Left(words(i), 1)) & LCase(Mid(words(i), 2))
		next
		ProperCase = Join(words, " ")
	End Function
	
	Function PhoneNumber(str)
		if Len(str) > 1 then
			str = Replace(str, "-", "")
			str = Replace(str, "(", "")
			str = Replace(str, ")", "")
			str = Replace(str, " ", "")
			
			PhoneNumber = "(" & Mid(str, 1, 3) & ") "& Mid(str, 4, 3) & "-" & Mid(str, 7, 4)
		else
			PhoneNumber = ""
		end if
	End Function
	
	Function Price(str)
		if Len(str) = 4 then 'Assuming that all rents/deposits <= 9999'
			str = Mid(str, 1, 1) & "," & Mid(str, 2, 3)
		end if
		Price = "$" & str
	End Function
	
	Dim num_features: num_features = 8
	Dim fs: fs = Array("heat", "gas", "water", "electric", "refrigerator", "furnished", "washer", "dryer")
	Dim f_abbrs: f_abbrs = Array("Hea", "Gas", "Wtr", "Elec", "Frg", "Furn", "Wsh", "Dry")
%>

<html lang='en-us'>
	<head>
		<title>Report</title>
		
		<link rel='stylesheet' href='/resources/stylesheets/reset.css'>
		
		<style type='text/css'>
			html {
				font: 10pt Corbel;
			}
			
			table {
				width: 10in;
				border-collapse: collapse;
			}
			
			thead {
				display: table-header-group;
			}
			
			tfoot td {
				border-top: .5pt solid black;
				text-align: right;
			}
			
			td, th {
				line-height: 15pt
			}
			
			td div, th div {
				overflow: hidden;
				white-space: nowrap;
			}
			
			#page_head td {
				border-bottom: .5pt solid black;
			}
			
			#column_heads th {
				border-bottom: 1pt solid black;
				margin-bottom: 2pt;
			}
			
			.address {
				width: 1.125in;
				padding-right: .125in;
			}
			
			.address div {
				width: 1.125in;
			}
			
			.unit_type {
				width: 1in;
			}
			
			.total_bedrooms, .total_bedrooms div, .available_bedrooms, .available_bedrooms div {
				width: .5in;
			}
			
			.date_available, .date_available div {
				width: .75in;
			}
			
			.primary_phone, .primary_phone div, .secondary_phone, .secondary_phone div {
				width: 1in;
			}
			
			.rent, .rent div, .security_deposit, .security_deposit div {
				width: .5in;
			}
			
			.feature, .feature div {
				width: .25in;
				text-align: center
			}
		</style>
	</head>
	<body>
		<table>
			<thead>
				<tr id='page_head'>
					<td><div>Mail Report</div></td>
					<td colspan='4'><div>Current as of <%= StripDate(Now) %></div></td>
					<td colspan='4'><div>www.subboard.com</div></td>
					<td colspan='<%= num_features %>'><div>SBI Off-Campus Housing</div></td>
				</tr>
				<tr>
					<td colspan='2'></td>
					<th colspan='2'><div>Bedrooms</div></th>
					<td colspan='5'></td>
					<th colspan='<%= num_features %>'><div>Rent Includes:</div></th>
				</tr>
				<tr id='column_heads'>
					<th class='address'><div>Address</div></th>
					<th class='unit_type'><div>Unit Type</div></th>
					<th class='total_bedrooms'><div>Total</div></th>
					<th class='available_bedrooms'><div>Open</div></th>
					<th class='date_available'><div>Available</div></th>
					<th class='primary_phone'><div>Home Phone</div></th>
					<th class='secondary_phone'><div>Work Phone</div></th>
					<th class='rent'><div>Rent</div></th>
					<th class='security_deposit'><div>Deposit</div></th>
<%	Dim i: for i=0 to num_features - 1 %>
					<th class='feature'><div><%= f_abbrs(i) %></div></th>
<%	next %>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan='9'></td>
					<td class='url' colspan='<%= num_features %>'>http://subboard.com/och/report.asp</td>
				</tr>
			</tfoot>
			
			<tbody>
<%	do while not listings.eof %>
				<tr>
					<td class='address'><div><%= listings("street_number") & " " & ProperCase(listings("street")) %></div></td>
					<td class='unit_type'><div><%= iif(listings("unit_type") = "Room in private house", "Room", listings("unit_type")) %></div></td>
					<td class='total_bedrooms'><div><%= listings("total_bedrooms") %></div></td>
					<td class='available_bedrooms'><div><%= listings("available_bedrooms") %></dv></td>
					<td class='date_available'><div><%= listings("date_available") %></div></td>
					<td class='primary_phone'><div><%= PhoneNumber(listings("primary_phone")) %></div></td>
					<td class='secondary_phone'><div><%= PhoneNumber(listings("secondary_phone")) %></div></td>
					<td class='rent'><div><%= Price(listings("rent")) %></div></td>
					<td class='security_deposit'><div><%= Price(listings("security_deposit")) %></div></td>
<%	for i=0 to num_features - 1 %>
					<td class='feature'><div><%= iif(listings(fs(i)), "x", "&nbsp;") %></div></td>
<%	next %>
				</tr>
<%	listings.MoveNext: loop %>
			</tbody>
		</table>
	</body>
</html>