<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Page Language="VBScript" Debug="true" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

  <HEAD>
    <title>Event Info</title>   
   

</HEAD>
<link href="..\staff_resources.css" rel="stylesheet" type="text/css">
  <body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" _
      marginwidth="0" marginheight="0">
   <%


 dim dateAt
 'Response.Write("Test")
  
 ' dateAt=4
 dateAt = Request.QueryString("Date")
 Response.Write(dateAt)
 dim temp


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
   
  While(dbread.Read())
    '// Created each time through the loop to get a new item 
    '// to load and add to the collection
 
    Response.Write("<div class=announcements>" & dbread.Item("Title")  & " " & dbread.Item("Department") & " " & dbread.Item("Information") & "</span><br>")
  End While

  'aString = CType(myCollection.Item(2)._Date, String)
  'Response.Write("the date is" & aString)
  dbread.Close()
   myConnection.Close()

   Response.Write("<br><a href=""addEvent.aspx"" class=""link"">Click Here to add an Announcement or Event</a>")
%>
  
  </body>
</HTML>
