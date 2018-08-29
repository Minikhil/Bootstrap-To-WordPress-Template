<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Page Language="VBScript" Debug="true" %>
<%@ Import Namespace="System.Web.Mail" %>



<Script runat="server">
Sub Page_Load( Sender As Object, e As EventArgs)
  If Not Page.IsPostBack then
    'Add the items to the _Type DropDownList Web Control
    _Type.Items.Add(new ListItem("Event", "1"))
    _Type.Items.Add(new ListItem("Announcement", "2"))       
    


    _Date.SelectedDate = Request.QueryString("Date")
  End If
End Sub


Sub Do_Insert(Sender As Object, e As EventArgs)
    'Only update the database if the user entered valid inputs
    If Not Page.IsValid then Exit Sub



   

    'Add the event to the database - 9/17/07, having trouble on new web server, so email then manual add
    'Dim myConnection As New _
           'OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0; data source=" & server.mappath("db\sbi-calendar4.mdb"))
    'Dim myCommand As New _
           'OleDbCommand("INSERT INTO Events (Title, Department, Information, Type, theDate) VALUES ('" & Replace(Title.Text, "'","")  & "', '" & Replace(Department.Text, "'", "") & "', '" & Replace(Information.Text, "'", "") & "', " & _Type.SelectedItem.Value & ", #" & _Date.SelectedDate & "#)", myConnection)

    'myCommand.CommandType = CommandType.Text
      
    'myConnection.Open()
      
		 'myCommand.ExecuteNonQuery()

	    'myConnection.Close()

        dim subject
		subject = "SBI Calendar Submission"
		Dim objEmail as New MailMessage()
		objEmail.To = "jdb27@buffalo.edu"
		objEmail.From = "jdb27@buffalo.edu"
		objEmail.Cc = "jdb27@buffalo.edu"
		objEmail.Subject = subject
		objEmail.Body = Title.Text & vbCrLf & Department.Text & vbCrLf & Information.Text & vbCrLf & _Type.SelectedItem.Value & vbCrLf & _Date.SelectedDate
		objEmail.Priority = MailPriority.High

		
                SmtpMail.SmtpServer = "smtp.buffalo.edu"

		try
			SmtpMail.Send(objEMail)
			Response.Clear
    Response.Write(_Date.SelectedDate)
    Response.Redirect("event_popup4.aspx?Date=" & _Date.SelectedDate & "&Title=" & Title.Text)   'Redirect the user to the calendar
		
		catch exc as Exception
			Response.Write("<b>Send failure:</b>" + exc.ToString())
		End Try



	
End Sub
</script>

<form runat="server">
<table>
  <tr>
    <td valign="top">Event/Announcement:</td>
    <td><asp:TextBox width="350" id="Title" runat="server"/>
    <asp:RequiredFieldValidator id="rfv_Title" ControlToValidate="Title" 
            runat="server">* This is a required field</asp:RequiredFieldValidator>
    <br></td>
  </tr>
  <tr>
    <tr><td valign="top">Date:</td>
    <td valign="top"><asp:calendar id="_Date" runat="server" />
    <br></td></tr>
  </tr>
  <tr>
    <td valign="top">Department:</td>
    <td valign="top"><asp:TextBox id="Department" runat="server"/>
    <asp:RequiredFieldValidator id="rfvDepartment" ControlToValidate="Department" 
            runat="server">* This is a required field</asp:RequiredFieldValidator>
    <br></td>
  </tr>
  <tr>
    <td valign="top">Information (255 Characters Max):</td>
    <td valign="top"><asp:TextBox id="Information" width="350" rows="7" TextMode="multiline" runat="server"/>

    <asp:RequiredFieldValidator id="rfvInformation" ControlToValidate="Information" 
             runat="server">* This is a required field</asp:RequiredFieldValidator>
    <br></td>
  </tr>
  <tr>
    <td valign="top">Type:</td>
    <td valign="top"><asp:dropdownlist id="_Type" runat="server" />
    <asp:RequiredFieldValidator id="rfv_Type" ControlToValidate="_Type" 
          runat="server">* This is a required field</asp:RequiredFieldValidator>
    <br></td>
  </tr>
  <tr>
    <td valign="top"> </td>
    <td align="center"><asp:Button id="Submit" text="Submit" 
           OnClick="Do_Insert" runat="server"/></td>
  </tr>
</table>
</form>

