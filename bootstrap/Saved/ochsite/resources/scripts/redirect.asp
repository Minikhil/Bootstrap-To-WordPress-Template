<%
	'The user should not see (or even load) the page content unless he is using a weird browser or specific security settings or something goes wrong.'
	
	Dim destination
	destination = Request.QueryString("destination")
%>

<% if not (destination = "") then
	'This is far less pretty than a simple Response.Redirect, but it works better.'
	Response.Status = "301 Permanently Moved"
	Response.AddHeader "Location", destination
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
	<head>
		<title>Redirect Failed</title>
	</head>
	<body>
		<h1>Redirect Failed</h1>
		<p>Your browser cannot redirect you to your destination. Click the following URL to go to your destination: <a href='<% Response.Write destination %>'><% Response.Write destination %></a>.</p>
	</body>
</html>

<% else %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
	<head>
		<title>Redirect Failed &mdash; No Destination</title>
	</head>
	<body>
		<h1>Redirect Failed &mdash; No Destination</h1>
		<p>No destination was supplied in the URL.</a>.</p>
	</body>
</html>

<% end if %>