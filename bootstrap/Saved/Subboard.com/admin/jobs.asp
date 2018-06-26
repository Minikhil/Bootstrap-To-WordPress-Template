<!-- #include virtual='/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	Dim db: set db = server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open "c:/Inetpub/wwwroot/resources/databases/jobs.mdb"
	
	Dim jobs: set jobs = server.CreateObject ("adodb.recordset")
	Dim query: query = "select * from jobs inner join divisions on jobs.division_id = divisions.id order by division_id, [position]"
	jobs.open query, db
	
	category = "Jobs"
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/resources/includes/head_new.inc -->
		
		<style type='text/css'>
			.job {
				overflow: hidden;
			}
			
			.job h4 {
				float: left;
			}
			
			.job h4.unavailable {
				font-weight: normal;
			}
			
			.job form {
				float: right;
			}
		</style>
	</head>
	<body>
		<!-- #include virtual=/resources/includes/header_new.inc -->
		
		<!-- #include virtual=/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Edit Available Jobs</h2>
			<p>To edit job descriptions please send an email to <a href="mailto:sbi-webmaster@buffalo.edu">sbi-webmaster@buffalo.edu</a>.</p>
			
<%
	Dim last_division: last_division = 0
	Dim jobs_available: jobs_available = false
	
	do until jobs.eof
		jobs_available = true
		if (jobs("division_id") <> last_division) then
			if (last_division > 0) then
%>
			</ul>
<%
			end if
			last_division = jobs("division_id")
%>
			<h3><% print jobs("division_name") %></h3>
			<ul class='jobs'>
<%		end if %>
				<li class='job'>
					<h4 class='<%= iif(jobs("available"), "available", "unavailable") %>'><%= jobs("title") %> (<%= iif(jobs("available"), "Available", "Unavailable") %>)</h4>
					<form action='toggle_job.asp' method='post'>
						<div><input type='hidden' id='id' name='id' value='<%= jobs("jobs.id") %>'></div>
						<div><input type='submit' id='action' name='action' value='Make <%= iif(jobs("available"), "Unavailable", "Available") %>'></div>
					</form>
				</li>
<%
		jobs.moveNext
	loop
%>
			</ul>
		</div>
		
		<div id='secondary'>
			<p><a href='/jobs.asp'>Back to jobs page</a></p>
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>