<html>
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Staff Resource Poll</title>
	<link href="style1.css" rel="stylesheet" type="text/css">
	<link href="sbiFooter.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="menuMouseovers.js"></script>
</head>
<body style="background-image:url('images/layout/thinLines2.jpg');background-repeat:repeat-x;">


<table width="518" border="0" cellspacing="0" cellpadding="0">
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

<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0">




 		<font class="text2">	
			<%
			dim poll_type, counter, result(), max, length, temp
			counter = 0
			max = 0					
			length = 0

			Set fs=Server.CreateObject("Scripting.FileSystemObject")
			Set results=fs.OpenTextFile(Server.MapPath("polls/results.log"), 1)
			While not results.AtEndOfStream
				length = length + 1
				Redim PRESERVE result(length)
				result(length) = CInt(results.ReadLine)
			Wend
			results.close
			Set poll=fs.OpenTextFile(Server.MapPath("polls/questions.txt"), 1)
			poll_type = CInt(poll.ReadLine)					

			response.write("<form action='http://www.subboard.com/staff_resource/'>")
			response.write("<br>" & poll.ReadLine & "<br>" & vbCrLf)
			response.write("<font class='text1'>")

			if poll_type = 1 then
				temp = CInt(Request.Form("options"))
				result(temp) = result(temp) + 1
			else
				for counter = 1 to length
					temp = Request.Form(CStr(counter))
					if temp = "on" then result(counter) = result(counter) + 1
				next
			end if
			
			Set results=fs.OpenTextFile(Server.MapPath("polls/results.log"), 2)
			for counter = 1 to length
				if max < result(counter) then max = result(counter)
				results.WriteLine (result(counter))
			next
			results.close

			counter = 0
			While not poll.AtEndOfStream
				counter = counter + 1
				if result(counter) = max then response.write ("<b>")
				response.write ("<br>" & poll.ReadLine & " (" & result(counter) & ")" & vbCrLf)
				if result(counter) = max then response.write ("</b>")
			Wend
			response.write("</font>")
			response.write("<br><br><INPUT TYPE='submit' value='Return to Staff Resource Page'>" & vbCrLf)
			response.write("</form>" & vbCrLf)
			poll.Close
			
			Set results=Nothing
			Set poll=Nothing
			Set fs=Nothing

			%>
			</font>
		</div>
	</td>

	</table>


</body>
</html>