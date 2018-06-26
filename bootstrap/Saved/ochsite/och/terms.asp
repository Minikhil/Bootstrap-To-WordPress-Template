<!-- #include virtual='/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<!-- #include virtual='/och/resources/scripts/upload.asp' -->

<%
	category = "Advertise"
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
        <script language="JavaScript">
<!-- Begin
function checkCheckBox(f){
if (f.agree.checked == false )
{
alert('Please check the box to continue.');
return false;
}else


return true;
}
//  End -->
</script>
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<br></br>
			<h3>Off-Campus Housing Listing Removal Policy:</h3>
<ol style="list-style-type:none">          
<li> A listing shall be removed, without refund, if: 
<p> 
</p>
	<li>I. Landlord has placed false information in the advertisement
		<li>II. Unit has failed an inspection by the local, state, or federal government
			<li>III. Unit is deemed uninhabitable by the local, state, or federal government
				<li>IV. Unit is condemned by the local, state, or federal government
					<li>V. Unit  has been rented
						<li> VI. Unit does not meet:
</ol>
<ol>
   <ul style="list-style-type:none">
	   	<li>a. Building Code of New York State, and/or
		   <li>b. Residential Code of New York State, and/or
			   <li>c. Existing Building Code of New York State, and/or
				   <li>d. Fire Code of New York State, and/or
					   <li>e. Plumbing Code of New York State, and/or
						   <li>f. Mechanical Code of New York State, and/or
							   <li>g. Fuel Gas Code of New York State, and/or
								   <li>h. Energy Conservation Construction Code of New York State, and/or
									   <li>i. Property Maintenance Code of New York State
   </ul>
</ol>
	<p>
</p>
<ol style="list-style-type:none">  
<li>VII. Buffalo Landlords (of one- and two- family non-owner occupied units) not registered with the Rental Registry
</li>

<p><h3>Smoke Detectors and Carbon Monoxide Detectors Placement Requirements (Residential Code of New York State):</h3>
<p>SECTION R313 SMOKE ALARMS, CARBON MONOXIDE ALARMS AND AUTOMATIC SPRINKLER SYSTEMS</p>
 
<p><h4>Smoke Detectors</h4>
<p>R313.1.1 Location. Smoke alarms shall be installed in the following locations:</p>
	<ol>
		<li>In each sleeping room.
			<li>Outside each separate sleeping area in the immediate vicinity of the bedrooms.
				<li>On each additional story of the dwelling, including basements but not including crawl spaces and uninhabitable attics. In dwellings or dwelling units with split levels and without an intervening door between the adjacent levels, a smoke alarm installed on the upper level shall suffice for the adjacent lower level provided that the lower level is less than one full story below the upper level. 
	</ol>
<p>When more than one smoke alarm is required to be installed within an individual dwelling unit the alarm devices shall be interconnected in such a manner that the actuation of one alarm will activate all of the alarms in the individual unit. </p>

<p><h4>Carbon Monoxide Detectors</h4></p>
<p>R313.4.2 Required locations. Carbon monoxide alarms shall be provided in the following locations:
	<ol>
		<li>Within each dwelling unit on each story containing a sleeping area, within 15 feet of the sleeping area. More than one carbon monoxide alarm shall be provided where necessary to assure that no sleeping area on a story is more than 15 feet away from a carbon monoxide alarm.
		<li>On any story of a dwelling unit that contains a carbon monoxide source. 
	</ol>		
				
			<p><h3>Certificate of Occupancy</h3></p>
			<p>A Certificate of Occupancy is a document that is issued by your local municipality (village, town, city, etc.) indicating that the property has been inspected by a Licensed Building Inspector (usually from the Department of Buildings or Licenses and Inspection) and meets the requirements for habitation based on the buildings classification. For many municipalities this is a requirement before any structure may be inhabited by tenants and/or businesses. Several municipalities call the Certificate of Occupancy by a different name; such as a Certificate of Compliance or a Certificate of Habitation. 
			<p>Not all municipalities require a certificate, and some do not offer certificates to certain classifications of property. Because a municipality does not require an inspection, does not mean that the property cannot be inspected.  Contact your local municipality and ask if they provide safety/building inspections for your property.</p>
			<p><h4>Certificate of Occupancy Listing Options:</h4></p>
<p>SBI Off-Campus Housing is mandating that all listing indicate the status of the Certificate of Occupancy.  There are four (4) options to choose from.  See below for their definitions.</p>


	<h4>Verified:</h4>            
		<p>1) Municipality offers a Certificate of Occupancy for this property.</p>
		<p>2) Landlord has been issued a certificate by the municipality within the last 24 months prior to listing.</p>
		<p>3) SBI Off-Campus Housing has received a copy of and has confirmed the Certificate of Occupancy from the Landlord or his/her agent.</p>
		<p><h4>Not Verified:</h4></p>      
		<p>1) Municipality offers a Certificate of Occupancy for this property.</p>
		<p>2) Landlord has been issued a certificate by the municipality within 24 months of listing.</p>
		<p>3) SBI Off-Campus Housing has NOT received a copy of and has NOT confirmed the Certificate of Occupancy from the Landlord or his/her agent.</p>

		<br></br>


<p><h4>To Continue you must click	
			<form name="terms" action="new_listing.asp" method="get" onSubmit="return checkCheckBox(this)">
I Understand: <input type="checkbox" value="0" name="agree"> <br>
<input type="submit" value="Continue" >
<!--<input type="button" value="Exit" onclick="document.location.href='new_listing.asp';"> -->
</form>

			

		
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>