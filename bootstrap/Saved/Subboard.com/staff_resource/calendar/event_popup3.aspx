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


   <%


 dim dateAt
 'Response.Write("Test")
  
 ' dateAt=4
 ID = Request.QueryString("ID")
 'Response.Write(dateAt)
 dim temp

    dim title
	dim department
	dim information
	dim theDate
    dim dbread
	dim sqlStatement
	sqlStatement="SELECT Events.ID, Events.Title, Events.Department, Events.Information, Events.Type, Events.theDate FROM Events WHERE (((Events.ID)=" & ID & "))"

    Dim myConnection As New _
           OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; data source=" & server.mappath("db\sbi-calendar4.mdb"))
    Dim myCommand As New _
           OleDbCommand(sqlStatement, myConnection)

    dim writeString

    myCommand.CommandType = CommandType.Text

    myConnection.Open()
        dbread=myCommand.ExecuteReader()
   
  While(dbread.Read())
    '// Created each time through the loop to get a new item 
    '// to load and add to the collection
  ' Response.Write("<div class=announcements>" & dbread.Item("Title")  & " " & dbread.Item("Department") & " " & dbread.Item("Information") & "</span><br>")
  title = dbread.Item("Title")
  department = dbread.Item("Department")
  information = dbread.Item("Information")
  theDate = dbread.Item("theDate")

End While
    writeString = "<tr><td height=""25"" bgcolor=""0078D3""><font class=""eventpopup"">" & theDate & "</font> </td></tr>"
	writeString = writeString & "<tr><td valign=""top"" bgcolor=""EBF3FC""><table width=""100%""  border=""0"" cellspacing=""2"" cellpadding=""2"">"
	writeString = writeString & "<tr><td height=""21"" bgcolor=""#FFFFFF""><font class=""eventtitle"">" & title & "</font> </td></tr>"
    writeString = writeString & "<tr><td height=""21""><font class=""eventtitle2"">Department:</font> <font class=""eventtext"">" & department & "</font></td></tr>"
	writeString = writeString & "  <tr> <td height=""120"" valign=""top"" bgcolor=""#FFFFFF""><font class=""eventtitle2"">Information:</font> <br>             &nbsp;<font class=""eventtext"">" & information & "</font></td>         </tr> "
    writeString = writeString & "<tr><td height=""14""></td></tr>"
	Response.Write(writeString)
  
  

  'aString = CType(myCollection.Item(2)._Date, String)
  'Response.Write("the date is" & aString)
  dbread.Close()
   myConnection.Close()


   
   
'Response.Write("<br><a href=""addEvent.aspx"" class=""link"">Click Here to add an Announcement or Event</a>")
%>

 

  
       
      
   





        
      </table></td>
    </tr>
  </table>


 </body>
</HTML>