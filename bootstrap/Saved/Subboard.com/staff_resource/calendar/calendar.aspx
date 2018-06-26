<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Page Language="VBScript" Debug="true" %>



<script type="text/javascript" src="..\Bubble\BubbleTooltips.js"></script>
<script type="text/javascript">
window.onload=function(){enableTooltips("content")};
</script> 


<link href="..\staff_resources.css" rel="stylesheet" type="text/css">
<style type="text/css">

<!--
body {
	background-color: #F6F9FC;
}
-->


</style>

<script language="JavaScript">

<!--

function MM_openBrWindow(theURL,winName,features) { //v2.0

  window.open(theURL,winName,features);

}



function n1(url)

{window.open(url,"name1","width=600,height=400, scrollbars=yes,resizable=yes");}

//-->



</script>



</script>

<Script runat="server">


Public Structure MyDates
  Dim _Title as String
  Dim _Date as DateTime
  Dim _Type as String
  Dim _Info as String
End Structure


Public MyCollection As Collection 
Public tempDate As DateTime 


Public Sub Page_Load()
  tempDate = Calendar1.TodaysDate
 If Not (Page.IsPostBack) Then
	Get_DBItems()   '// The Sub that loads the collection
 End if
End Sub

Private Sub MonthChanged(source As Object, e As MonthChangedEventArgs)
   '//Set the tempDatevariable to the value in the 
   '//MonthChangedEventArgs NewDate property  
   tempDate = e.NewDate
   
   '//Reload the collection
 
  Get_DBItems() 
End Sub

Private Sub Calendar1_DayRender(source As Object, e As DayRenderEventArgs)

 
  'aString = CType(myCollection.Item(2)._Date, String)
  'Response.Write("the date is" & aString)
   'dim dateString
   'dim typeInt
   'dim titleString
   'dim x
	 
	 'For Each x in myCollection
     'dateString = CType(x._Date, String)
     'typeInt = CType(x._Type, Integer)
	 'titleString = CType(x._Title, String)

     'If (typeInt=1) Then
      '  Response.Write("Type 1")
	    'Dim cellColor = e.Cell.BackColor
      'e.Cell.BackColor=System.Drawing.Color.Red


   '  Else if (typeInt=4) Then
	    'Response.Write("Type 4")
'Dim cellColor = e.Cell.BackColor
'     End if

     'Next


   dim dateString
   dim typeString
   dim titleString
    dim typeInt as New Integer 
   dim x
   dim cellColor
	 
	 For Each x in myCollection
	
     dateString = CType(x._Date, DateTime)
     typeString = CType(x._Type, String)
	 typeInt = CType(x._Type, Integer)
	 titleString = CType(x._Title, String)
    ' Response.Write("<br> date = " & dateString & " type = " & typeString & " title = " & titleString & "<br>")
	' Response.Write("Compare tempdate to dateString: " & e.Day.Date & ": " & dateString)
	 
	 
     If (dateString.CompareTo(e.day.Date)=0) Then
     
      'e.Cell.BackColor=System.Drawing.Color.Red


           if (typeInt=1) Then
	 
               e.Cell.BackColor=System.Drawing.Color.Red

	       else if (typeInt=2) Then
	  
	           e.Cell.BackColor=System.Drawing.Color.Magenta

           else if (typeInt=3) Then
	  
	           e.Cell.BackColor=System.Drawing.Color.Gold

	        End if 

     End if

     Next






      Dim hl As New HyperLink()
        hl.Text = CType(e.Cell.Controls(0), LiteralControl).Text
        ' set the navigation url (the href attribute) to the javascript 
        ' procedure
        ' defined wihin the client-side <script> block, and pass in input
        ' the clicked date in short format
         hl.NavigateUrl = "javascript:n1('event_popup2.aspx?Date=" & e.Day.Date.ToShortDateString() & "' ,'','width=600,height=600');"
        'hl.NavigateUrl = "javascript:SetDate('" & e.Day.Date.ToShortDateString() _ & "');"

        e.Cell.Controls.Clear()
        e.Cell.Controls.Add(hl)


  'Get_DBItems()
End Sub




Sub Get_DBItems()
 
    dim dbread
	dim sqlStatement
	sqlStatement="SELECT Events.ID, Events.Title, Events.Department, Events.Information, Events.Type, Events.theDate FROM Events WHERE (((Month([theDate]))=" & tempDate.Month & ")) ORDER BY theDate"

    Dim myConnection As New _
           OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; data source=" & server.mappath("db\sbi-calendar4.mdb"))
    Dim myCommand As New _
           OleDbCommand(sqlStatement, myConnection)

    myCommand.CommandType = CommandType.Text

    myConnection.Open()
        dbread=myCommand.ExecuteReader()
   

myCollection = New Collection()
  Dim temp As myDates

'Bubbles!
Response.Write("<div id=""content"">")


  While(dbread.Read())
    '// Created each time through the loop to get a new item 
    '// to load and add to the collection
    temp = New MyDates()

    temp._Title = dbread.Item("Title")
    temp._Date = CDate(dbread.Item("theDate"))
    temp._Type = dbread.Item("Type")
    temp._Info = Left(dbread.Item("Information"), 140)
	
   ' Response.Write("date = " & tempDate)
   'if temp._Date < tempDate
    MyCollection.Add(temp)
	'End If
   
if temp._Date >= tempDate AND temp._Type <> "3"

'Response.Write("<a href=""#"" class=""link2"" onClick=""MM_openBrWindow('event_popup3.aspx?ID=" & dbread.Item("ID") & "','','width=415,height=300')"">" &  temp._Date  & " " & temp._Title &"</a><br>")
Response.Write("<a href=""#"" title=""" & temp._Date & ": " & temp._Info & "..."" class=""link3"" onClick=""MM_openBrWindow('event_popup3.aspx?ID=" & dbread.Item("ID") & "','','width=415,height=300')"">" &  temp._Date  & " </a>")
Response.Write("<a href=""#"" title=""" & temp._Date & ": " & temp._Info & "..."" class=""link2"" onClick=""MM_openBrWindow('event_popup3.aspx?ID=" & dbread.Item("ID") & "','','width=415,height=300')"">" & temp._Title & "</a><br>")

    'Response.Write("<div class=list>" &  temp._Date  & " " & temp._Title & "</span><br>")

End if 


  End While

'End Bubbles
Response.Write("</div>")


  'aString = CType(myCollection.Item(2)._Date, String)
  'Response.Write("the date is" & aString)
  dbread.Close()
   myConnection.Close()











End Sub

</script>

<form runat="server">
<img src="../images/calendar_green.gif" width="63" height="11"> <img src="../images/calendar_red.gif" width="35" height="11"> <img src="../images/calendar_margenda.gif" width="76" height="11"> <img src="../images/calendar_gold.gif" width="59" height="11">
<asp:Calendar OnDayRender="Calendar1_DayRender" 
    OnVisibleMonthChanged="MonthChanged"
    SelectionMode="Day" 
    DayNameFormat="short"
    DayStyle-Font-Size="10" 
    Runat="server" id="Calendar1">
   

   <WeekendDayStyle BackColor="#FEFECD" ForeColor="#CA0000" />
   <DayHeaderStyle ForeColor="#0000ff" BackColor="#ffffff"/>
   <TodayDayStyle BackColor="#69FE56" />


</asp:Calendar> 



</form>



