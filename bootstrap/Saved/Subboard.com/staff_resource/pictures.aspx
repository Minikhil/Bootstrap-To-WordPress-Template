<%
lbl1.Text=Month(now) & "." & Day(now) & "." & Year(now) 
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>SBI Staff Resources</title>
<SCRIPT LANGUAGE="JavaScript" SRC="/staff_resource/mktree.js"></SCRIPT>
<link href="staff_resources.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
-->
</style></head>

<body>

<body onload="changeColour('blinky');">
<script type="text/javascript"><!--
function changeColour(elementId) {
var interval = 500;
var colour1 = "red", colour2 = "black";
if (document.getElementById) {
var element = document.getElementById(elementId);
element.style.color = (element.style.color == colour1) ? colour2 : colour1;
setTimeout("changeColour('" + elementId + "')", interval);
}
}

     

//--></script>

       




<center>
<table width="748" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="19"></td>
  </tr>
  <tr>
    <td align="left"><img src="images/staff_re_img01.gif" width="102" height="50"><img src="images/staff_re_img02.gif" width="222" height="50"></td>
  </tr>
  <tr>
   
 <td height="20"  align=left background="images/staff_re_img04.gif">
 <table with="748" border="0" cellpadding="0" cellspacing="0">
 <tr><td width="120">
            <a href="index.aspx#date" target="_self" class="date" runat="server"> <asp:label id="lbl1" runat="server" /></a></td><td width="628" align="right"><a href="index.aspx" target="_self" class="home3">Home</a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>
        

         
		 </td>



  </tr>
  <tr>
    <td height="7"></td>
  </tr>
    <tr>

<!--#include file="timesheets\TimesheetInclude.html"-->

<span id="blinky"> </span>
  </tr>
  <tr>
    <td height="12">&nbsp;</td>
  </tr>
</table>
<table width="748" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="748" align="left" valign="top"><table width="748" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
      <tr bgcolor="#B6D1EF">
        <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
        <td height="28" align="left"><font class="stitle">SBI Photos</font></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td align="left">


  <br>

	> <a href="http://www.subboard.com/staff_resource/picasa/sbi_picnic_2009/index.html" target="_blank" class="list"><b>SBI Picnic 2009</b></a><br>
    <br>
	> <a href="http://www.subboard.com/staff_resource/picasa/halloween_08/index.html" target="_blank" class="list"><b>Halloween 2008</b></a><br>
    <br>
	> <a href="http://www.subboard.com/staff_resource/picasa/spectrum%20pics/index.html" target="_blank" class="list"><b>Mrs. Henry's Brick</b></a><br>
    <br>
	> <a href="http://www.subboard.com/staff_resource/picasa/bill's%20baby%20shower%2008/index.html" target="_blank" class="list"><b>Bill's Baby Shower</b></a><br>
    <br>

	> <a href="picasa/sbi picnic 07/index.html" target="_blank" class="list"><b>SBI Picnic 2007</b></a><br>
    <br>
	> <a href="picasa/SBI Flashback/index.html" target="_blank" class="list"><b>SBI Flashback</b></a><br>

    <br>
	> <a href="picasa/SBI Holiday Party 2006 - Part 2/index.html" target="_blank" class="list"><b>Holiday Party 2006 - Part 2</b></a><br>

    <br>
	> <a href="picasa/SBI Holiday Party 2006/index.html" target="_blank" class="list"><b> Holiday Party 2006</b></a><br>
	<br>
	> <a href="multimedia/cgi-bin/emAlbum.cgi" target="_blank" class="list">SBI Photo Archive</a><br>


	


       </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>


	<br>

	</td>
  </tr>
</table>
<br>
<br>
<!--#include file="includes/footer.asp"-->
<br>
</center>
</body>

</HTML>
