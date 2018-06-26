<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Page Language="VBScript" Debug="true" %>

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
          
    
   <%


 dim dateAt
 'Response.Write("Test")
  
 ' dateAt=4
 dateAt = Request.QueryString("Date")
 dim temp

Response.Write("<td height=""40"" align=""center""><a href=""addEvent.aspx?Date=" & dateAt & """><img src=""../images/button_add_event.gif"" width=""147"" height=""23"" border=""0""></a></td></tr>")

    dim writeString
	dim title
	dim information
	dim department
    dim dbread
	dim sqlStatement
	sqlStatement="SELECT Events.ID, Events.Title, Events.Department, Events.Information, Events.Type, Events.theDate FROM Events WHERE (((Events.theDate)=#" & dateAt & "#))"

    Dim myConnection As New _
           OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; data source=" & server.mappath("db\sbi-calendar4.mdb"))
    Dim myCommand As New _
           OleDbCommand(sqlStatement, myConnection)

    myCommand.CommandType = CommandType.Text

    myConnection.Open()
        dbread=myCommand.ExecuteReader()
   

Response.Write("<tr><td height=""25"" bgcolor=""0078D3""><font class=""eventpopup"">" & dateAt & "</font> </td></tr>")
  While(dbread.Read())
    '// Created each time through the loop to get a new item 
    '// to load and add to the collection
 
    'Response.Write("<div class=announcements>" & dbread.Item("Title")  & " " & dbread.Item("Department") & " " & dbread.Item("Information") & "</span><br>")
	title = dbread.Item("Title")
	information = dbread.Item("Information")
	department = dbread.Item("Department")

    writeString =  "<tr><td valign=""top"" bgcolor=""EBF3FC""><table width=""100%""  border=""0"" cellspacing=""2"" cellpadding=""2""><tr>"
    writeString = writeString & "<td height=""21"" bgcolor=""#FFFFFF""><font class=""eventtitle"">" & title & "</font></td></tr>"
    writeString = writeString & "<tr><td height=""21""><font class=""eventtitle"">Department:</font> <font class=""eventtext"">" & department & "</font></td></tr>"
    writeString = writeString & "<tr><td height=""120"" valign=""top"" bgcolor=""#FFFFFF""><font class=""eventtitle"">Information:</font> <br>"
    writeString = writeString & "&nbsp;<font class=""eventtext"">" & information & "</font></td></tr>"
	Response.Write(writeString)

  End While

  'aString = CType(myCollection.Item(2)._Date, String)
  'Response.Write("the date is" & aString)
  dbread.Close()
   myConnection.Close()

  



%>



 







      
      </table></td>
    </tr>
  </table>


 </body>
</HTML>