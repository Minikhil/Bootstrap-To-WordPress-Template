<!-- #include file=resources/initialize.inc -->
<%
	category = "Pay for listing"	
	Dim db: Set db = Server.CreateObject("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
%>
<html lang='en-us'>
	<head>
	<meta http-equiv='Content-type' content='text/html; charset=iso-8859-1'>
	<title>Off-Campus Housing and Apartments at UB</title>
       <link type='text/css' href='css/och.css' rel='stylesheet' media='screen' />
       <script language="javascript">
       function checkCheckBox(f) {
           if(!f.agree.checked) {
               alert('Please check the box to continue.');
               return false;
           }
           else return true;
       }
       </script>
	</head>
