<html>
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Staff Resource Poll</title>
	<link href="style1.css" rel="stylesheet" type="text/css">
	<link href="sbiFooter.css" rel="stylesheet" type="text/css">
</head>

	<table width="518" border="0" cellspacing="0" cellpadding="0">
	  <tr bgcolor="#FFFAFA">
		Scroll to bottom to vote.  Please note, these designs are for the back of the t-shirt.
    </tr>
    <tr bgcolor="#FFFAFA">
      <td align="center" >T-Shirt 1: <br><IMG SRC="tshirt1-1.jpg" ALT="tshirt 1"></td>
      <td align="center" >T-Shirt 2: <br><IMG SRC="tshirt2-2.jpg" ALT="tshirt 2"></td>
	  <td align="center" >T-Shirt 3: <br><IMG SRC="tshirt3-1.jpg" ALT="tshirt 3"></td>
    </tr>
	 <tr bgcolor="#FFFAFA">
      <td align="center" >T-Shirt 4: <br><IMG SRC="tshirt4.jpg" ALT="tshirt 5"></td>
      <td align="center" >T-Shirt 5: <br><IMG SRC="tshirt5.jpg" ALT="tshirt 6"></td>
    </tr>
  </table>  
  <table width="518" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td colspan="3"><img src="images/dotbar.gif" width="518" height="3"></td>
    </tr>
	</table>	


<table>

	<!--PAGE CONTENT CELL-->

	<td width="477" align="left" valign="top" class="interiorContentBackground">
		<div style="padding:15;">
 		<font class="text2">
		
		<%
			dim poll_type, counter
			counter = 0					

			Set fs=Server.CreateObject("Scripting.FileSystemObject")
			Set poll=fs.OpenTextFile(Server.MapPath("polls/questions.txt"), 1)
			poll_type = CInt(poll.ReadLine)
			
			response.write("<form method=post action='pollresults.asp'>")
			response.write("<br>" & poll.ReadLine & "<br>" & vbCrLf)
			response.write("<font class='text1'>")
								
			While not poll.AtEndOfStream
				counter = counter + 1
				if poll_type = 1 then
					response.write ("<br><INPUT TYPE='radio' Name='options' value='" & counter & "'>" & poll.ReadLine & vbCrLf)
				else
					response.write ("<br><INPUT TYPE='checkbox' Name='" & counter & "'>" & poll.ReadLine & vbCrLf)
				end if
			Wend
			response.write("</font>")
			response.write("<br><br><INPUT TYPE='submit' value='&nbsp;&nbsp;&nbsp;vote&nbsp;&nbsp;&nbsp;'>" & vbCrLf)
			response.write("</form>" & vbCrLf)
			poll.Close

			Set poll=Nothing
			Set fs=Nothing

			%>
			</font>
		</div>
	</td>


</table>

</body>
</html>