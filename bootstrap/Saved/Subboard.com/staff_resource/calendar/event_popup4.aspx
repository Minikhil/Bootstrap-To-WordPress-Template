<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Page Language="VBScript"%>


<HTML>

  <HEAD>
    <title>Event Info</title>   
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><style type="text/css">
<!--
body {
	margin-left: 2px;
	margin-top: 2px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {font-size: 9px}
-->
    </style></HEAD>
<link href="..\staff_resources.css" rel="stylesheet" type="text/css">
  <body >
  <table width="100%" height="300"  border="0" cellpadding="1" cellspacing="2">
    <tr>
      <td height="25" bgcolor="0078D3" align="center"><font class="eventpopup">Your event has been submitted for review. </font> </td>
    </tr>
    <tr>
      <td valign="top" bgcolor="EBF3FC"><table width="100%"  border="0" cellspacing="2" cellpadding="2">

        <tr>
          <td height="14"></td>
        </tr>
        <tr>
          <td height="40" align="center">
<% 

	dim theDate
	dim title

      theDate = Request.QueryString("Date")
	  title = Request.QueryString("Title")


     Response.Write("<a href=""http://www.subboard.com/staff_resource/calendar/marketingRequest.aspx?Date=" & theDate & "&Title=" & title & """>Marketing Request Form</a>")
	  %>
       </td>
        </tr>
      </table></td>
    </tr>
  </table>


 </body>
</HTML>