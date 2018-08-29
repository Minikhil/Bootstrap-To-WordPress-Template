
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
    <td width="191" align="left" valign="top"><table width="168" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
      <tr bgcolor="#B6D1EF">
        <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
        <td height="28" align="left"><font class="stitle">Forms</font></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td align="left">


<!--#include file="Includes\FormsInclude.html"-->


       </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
      <br>
      <table width="168" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
        <tr bgcolor="#B6D1EF">
          <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
          <td height="28" align="left"><font class="stitle">Important Links</font></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><table width="138" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td height="6" align="left"></td>
                <td align="left"></td>
              </tr>
              <tr>
                <td width="15" align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td width="120" height="20" align="left"><a href="http://www.subboard.com" target="_blank" class="link">Subboard.com</a></td>
              </tr>
              <tr>
                <td align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td height="20" align="left"><a href="http://www.buffalo.edu" target="_blank" class="link">Buffalo.edu</a></td>
              </tr>
              <tr>
                <td height="10" align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td height="20"><a href="http://myub.buffalo.edu" target="_blank" class="link">My UB </a></td>
              </tr>
              <tr>
                <td align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td height="20"><a href="http://www.google.com" target="_blank" class="link">Google</a></td>
              </tr>
              <tr>
                <td align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td height="20"><a href="https://ubibm.buffalo.edu/hod/hodthin.html" target="_blank" class="link">Host on Demand</a></td>
              </tr>
              <tr>
                <td align="center"><img src="images/staff_re_img07.gif" width="7" height="8"></td>
                <td height="20"><a href="/staff_resource/multimedia/cgi-bin/emAlbum.cgi" target="_blank" class="link"><b>**SBI Photos**</b></a></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    <td width="290" align="left" valign="top">
	<a name="date">
	<table width="267" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
      <tr bgcolor="#B6D1EF">
        <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
        <td height="28" align="left"><font class="stitle">Calendar</font></td>
      </tr>
      <tr>
        <td height="12"></td>
        <td></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
<td align="center" valign="top">
<iframe name="calendar" src='calendar/calendar.aspx' width=255 height=276  frameborder=0  scrolling='NO' bgcolor="#"></iframe>

</td>


      </tr>

    </table>
      <br>
      <table width="267" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
        <tr bgcolor="#B6D1EF">
          <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
          <td width="252" height="28" align="left"><font class="stitle">Contact Technical Support </font></td>
        </tr>
        <tr>
          <td height="6"></td>
          <td align="left"></td>
        </tr>
        <tr align="center">
          <form name="feedbackform1" method="post" action="http://wings.buffalo.edu/cgi-bin/wingsmail"><td colspan="2">
		  <input type="hidden" name="to" value="sbi-consult@buffalo.edu">
          <input type="hidden" name="subject" value="User Feedback">
          <input type="hidden" name="source" value="Staff Website">
          <input type="hidden" name="return" value="http://www.subboard.com/staff_resource/index.aspx">
            <textarea name="textarea" cols="29" rows="4"></textarea><br><br>
			<div class="email">Email Address (optional) </div>
           <input type="text" name="email" size="29" maxlength="100"> 
          <input type="image" SRC="images/staff_re_img03.gif" width="60" height="18" name="Submit" value="Submit">
            </td></form>

        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    <td align="left" valign="top"><table width="267" border="0" cellpadding="1" cellspacing="0" bgcolor="#F6F9FC">
      <tr bgcolor="#B6D1EF">
        <td width="15" align="center"><img src="images/staff_re_img05.gif" width="9" height="8"></td>
        <td height="28" align="left"><font class="stitle">SBI Contact List </font></td>
      </tr>
      <tr>
        <td height="12"></td>
        <td></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td align="left" valign="top"><table width="232" border="0" cellspacing="1" cellpadding="0">
         

<A href="#" onClick="expandTree('tree1'); return false;"></A>
<A href="#" onClick="collapseTree('tree1'); return false;"></A>

		  
<ul class="mktree" id="tree1">


	<li>Business Office
		<ul> 
		     <li> 
		        Phone: 645.2954 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\BusinessInclude.html"-->


	</li>


<li class="liClosed">Clinical Lab
		<ul> 
		     <li> 
		        Phone: 829.2367 <br>
			 </li>
			 <li>
				Fax: 829.2613
		     </li> 
		</ul>

<!--#include file="Includes\LabInclude.html"-->


	</li>





	<li class="liClosed">Executive

		<ul> 
		     <li> 
		        Phone: 645.2954 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\ExecutiveInclude.html"-->


	</li>


<li class="liClosed">Generation

		<ul> 
		     <li> 
		        Phone: 645.6131 <br>
			 </li>
			 <li>
				Fax: 645.2701
		     </li> 
		</ul>

<!--#include file="Includes\GenerationInclude.html"-->


	</li>





	<li class="liClosed">Group Legal Services

		<ul> 
		     <li> 
		        Phone: 645.3056 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\GLSInclude.html"-->


	</li>






	<li class="liClosed">Health Ed and Human Services

		<ul> 
		     <li> 
		        Phone: 829.2584 <br>
			 </li>
			 <li>
				Fax: 829.3641
		     </li> 
		</ul>

<!--#include file="Includes\HEHSInclude.html"-->


	</li>



	<li class="liClosed">Information Systems
		<ul> 
		     <li> 
		        Phone: 645.2954 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\ISInclude.html"-->


	</li>


	<li class="liClosed">Marketing

		<ul> 
		     <li> 
		        Phone: 645.2959 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\MarketingInclude.html"-->


	</li>






	<li class="liClosed">Off Campus Housing
		<ul> 
		     <li> 
		        Phone: 829.2224 <br>
			 </li>
			 <li>
				Fax: 829.2232
		     </li> 
		</ul>

<!--#include file="Includes\OCHInclude.html"-->


	</li>




<li class="liClosed">Pharmacy
		<ul> 
		     <li> 
		        Phone: 829.2368 <br>
			 </li>
			 <li>
				Fax: 829.2531
		     </li> 
		</ul>

<!--#include file="Includes\PharmacyInclude.html"-->


</li>




	<li class="liClosed">Planning and Development
		<ul> 
		     <li> 
		        Phone: 645.2954 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\PDInclude.html"-->


	</li>






	<li class="liClosed">Student Medical Insurance

		<ul> 
		     <li> 
		        Phone: 645.3036 <br>
			 </li>
			 <li>
				Fax: 645.3465
		     </li> 
		</ul>

<!--#include file="Includes\SMIInclude.html"-->


	</li>







	<li class="liClosed">Ticket Office
			
			<ul> 
		     <li> 
		        Phone: 645.2353 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\TOInclude.html"-->


	</li>







	<li class="liClosed">WRUB
			<ul> 
		     <li> 
		        Phone: 645.3370 <br>
			 </li>
			 <li>
				Fax: 645.2674
		     </li> 
		</ul>

<!--#include file="Includes\WRUBInclude.html"-->

	</li>

</ul>
        </table>
          
          </td>
      </tr>
<!--       <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr> -->
    </table>
	<br>

	</td>
  </tr>
</table>
<br>
<br>
<table width="644" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" bgcolor="#DFE6EF"></td>
  </tr>
    <tr>
    <td height="4"></td>
  </tr>
  <tr>
    <td align="left"><font class="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;
	  CREATED AND MAINTAINED BY Sub-Board I, Inc. <br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;
      &copy; 2005 Sub-Board I, Inc. - All Rights Reserved. </font></td>
  </tr>
</table>
<br>
</center>
</body>

</HTML>
