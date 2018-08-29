<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>




<script runat="server">    


   Sub btnSubmit_Click(sender as object, e as EventArgs)
        
     
        dim requests
		requests = "Requests for:" & vbCrLf
		' ASP.NET CheckBox Control:
		'campusCable.Text = " ASP.NET CheckBox Control Text Label"
		If campusCable.Checked Then
			requests = requests & "Campus Cable" & vbCrLf
		End If
        If flier1.Checked Then
			requests = requests & "8.5 x 11" & vbCrLf
		End If	
		If flier2.Checked Then
			requests = requests & "11 x 17" & vbCrLf
		End If
        If quarterSheets.Checked Then
			requests = requests & "Quarter Sheets" & vbCrLf
		End If
        If generation.Checked Then
			requests = requests & "Generation" & vbCrLf
		End If
        If suBanner.Checked Then
			requests = requests & "SU Banner" & vbCrLf
		End If
        If wrubPlug.Checked Then
			requests = requests & "WRUB On Air Plug" & vbCrLf
		End If
        If ubCal.Checked Then
			requests = requests & "UB Calendar" & vbCrLf
		End If
        If sbiWeb.Checked Then
			requests = requests & "SBI Website" & vbCrLf
		End If
        If MYUB.Checked Then
			requests = requests & "MYUB" & vbCrLf
		End If
        If busAd.Checked Then
			requests = requests & "Bus Advertisement" & vbCrLf
		End If

	 If sbiSR.Checked Then
			requests = requests & "Staff Resources Calendar" & vbCrLf
		End If

		If socialMedia.Checked Then
			requests = requests & "Twitter/Facebook" & vbCrLf
		End If

		If wrubEmail.Checked Then
			requests = requests & "WRUB Email Promo" & vbCrLf
		End If


        dim subject
		subject = "Marketing Request From " & name.Text & ":  Department: " & division.Text & " Phone: " & phone.Text
		Dim objEmail as New MailMessage()
		objEmail.To = "kelseyle@buffalo.edu,briankei@buffalo.edu,wrubgeneralmanager@gmail.com"
		objEmail.From = email.Text
		objEmail.Cc = email.Text 
		objEmail.Subject = subject
		objEmail.Body = requests & vbCrLf & vbCrLf & textInfo.Text
		objEmail.Priority = MailPriority.High

		
                SmtpMail.SmtpServer = "smtp.buffalo.edu"

		try
			SmtpMail.Send(objEMail)
			Response.Clear
			 Response.Redirect("confirmation.aspx")
		
		catch exc as Exception
			Response.Write("<b>Send failure:</b>" + exc.ToString())
		End Try
    End Sub


</script>




 





<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SBI Marketing Request Form</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
-->

</style></head>
 
 <center>
 <table width="100%" cellspacing="0" cellpadding="0" border="0">
 <tr><td>
 
 <table width="540" cellspacing="0" cellpadding="0" border="0">
 <tr>
 <td>
 <img src="../images/sbirequest.gif" width="540" height="70" />
 <br />

 
 <form runat="server">
	  <input type="hidden" name="good_url" value="http://www.subboard.com/staff_resource/" />
          <table width="500" cellspacing="0" cellpadding="0" border="0">
		   <tr>
		   <td width="10">&nbsp;</td>
			<td width="100">SBI Division:</td>
			<td width="100"><asp:TextBox runat="server"  Width="200" MaxLength="100" ID="division"></asp:TextBox></td>
		<td width="290"></td>
          </tr>  
		  



<tr>
                        <td width="10">&nbsp;</td>
						<td width="100">Name</td>
						<td width="100"> <asp:TextBox runat="server" Width="200" MaxLength="100" ID="name"></asp:TextBox> </td>
						<td width="290"></td>
					</tr>

					<tr>
                        <td width="10">&nbsp;</td>
						<td width="100">Phone Number</td>
						<td width="100"> 
						<asp:TextBox runat="server" Width="200" ID="phone"></asp:TextBox> </td>
						<td width="290"></td>
					</tr>
					<tr>
                        <td width="10">&nbsp;</td>
						<td width="100">Email</td>
						<td width="100"> 
						<asp:TextBox runat="server" Width="200" ID="email"></asp:TextBox></td>
					    <td width="290">
						<asp:RegularExpressionValidator ID = "reg3" ControlToValidate = "email" Runat = "server" ErrorMessage = "Invalid Email" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>&nbsp;
						</td>
					</tr>
					</table>
<br /><br />
		   <center>
		  <table width="520" cellspacing="0" cellpadding="0" border="0">
		  <tr>
			<td width="250" align="left">
		    Flier <asp:CheckBox id="flier1" runat="server" /> 8.5" x 11"
			      <asp:CheckBox id="flier2" runat="server" /> 11" x 17"
			</td>
			<td width="20">&nbsp;</td>
			<td width="250" align="left">
		    <asp:CheckBox id="campusCable" runat="server" />Campus Cable Advertisement
			</td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="quarterSheets" runat="server" /> Quarter Sheet Advertisements
			</td>
			<td width="20">&nbsp;</td>
			<td width="250" align="left">
		    <asp:CheckBox id="generation" runat="server" /> Generation Advertisement
			</td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="suBanner" runat="server" /> Banner (hung in Student Union)
			</td>
			<td width="20">&nbsp;</td>
			<td width="250" align="left">
		    <asp:CheckBox id="wrubPlug" runat="server" /> WRUB On Air Plug
			</td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="ubCal" runat="server" /> UB Calendar
			</td>
            <td width="20">&nbsp;</td>
			<td width="250" align="left">
		    <asp:CheckBox id="wrubEmail" runat="server" /> WRUB Email Promo
			</td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="MYUB" runat="server" /> MYUB
			</td>
            <td width="20">&nbsp;</td>
			<td width="250" align="left">
            <asp:CheckBox id="sbiSR" runat="server" /> SBI Staff Resource Calendar
            </td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="socialMedia" runat="server" /> Twitter/Facebook
			</td>
            <td width="20">&nbsp;</td>
			<td width="250" align="left">
		    <asp:CheckBox id="sbiWeb" runat="server" /> SBI Website
			</td>
		  </tr>
		  <tr>
		  	<td width="250" align="left">
		    <asp:CheckBox id="busAd" runat="server" /> Bus Advertisement
			</td>
            <td width="20">&nbsp;</td>
			<td width="250" align="left">
		    &nbsp;
			</td>
		  </tr>

		
		  </table><br /><br />
		  <table width="520" cellspacing="0" cellpadding="0" border="0">
		  <tr>
		  <td>
		  Use the space below to include <b>ALL</b> pertinent information (<b>other requests</b>, specified bulk copying needs, etc)<br />
		 
           <asp:TextBox runat="server" Width="500" ID="textInfo" textmode="multiline" cols="63" rows="12"></asp:TextBox>
		  </td>
		  </tr>
		  </table>


         

		<asp:Button Runat = server ID = btnSubmit OnClick = btnSubmit_Click input text="submit" SRC="../images/staff_re_img03.gif"></asp:Button>
		<br><asp:RequiredFieldValidator ID = "req5" ControlToValidate = "email" Runat = "server" ErrorMessage = "Please enter email address" ></asp:RequiredFieldValidator>	<br>
<asp:RequiredFieldValidator ID = "req4" ControlToValidate = "phone" Runat = "server" ErrorMessage = "Please enter phone number" ></asp:RequiredFieldValidator> <br>
<asp:RequiredFieldValidator ID = "req3" ControlToValidate = "name" Runat = "server" ErrorMessage = "Please enter your Name" ></asp:RequiredFieldValidator> <br>
<asp:RequiredFieldValidator ID = "req1" ControlToValidate = "division" Runat = "server" ErrorMessage = "Please enter SBI division"></asp:RequiredFieldValidator> 
		</form>
</td></tr></table>
</center>

</td></tr></table>
</body>
</html>


