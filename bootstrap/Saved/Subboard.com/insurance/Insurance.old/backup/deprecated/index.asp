<!-- #include virtual='/resources/libraries/util2.lib' -->

<%
	dim category: category = "Student Medical Insurance"
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual='/insurance/resources/includes/head.inc' -->
		
		<style type="text/css" media="screen">
			#enroll-waive-link a {
				display: inline-block;
				
				padding: 6px;
				border: 2px solid #133366;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				
				background: #275b99;
				background: -moz-linear-gradient(top, #194183, #133366);
				
				/*background: -webkit-gradient(linear, center top, center bottom, from(#194183), to(#133366)) -moz-linear-gradient(top, #194183, #133366);*/
				
				font-size: 2em;
				font-weight: bold;
				text-decoration: none;
				color: white;
				text-shadow: -2px -2px #133366;
			}
		</style>
	</head>
	<body>
		<!-- #include virtual='/insurance/resources/includes/header.inc' -->
		
		<div id='content'>
			<h2>General Information</h2>
			
			<img src='/insurance/resources/images/departmentSmall.jpg'>
			
			<p><strong>SBI Student Medical Insurance</strong>, a service of <a href='http://subboard.com'>Sub-Board I, Inc.</a>, can assist you with filing claims and the insurance enrollment or waiver process.</p>
			
			<p id='enroll-waive-link'><a href='domestic_waive.asp'>Domestic Student Insurance Waiver</a></p>
			
			<p><strong>The University requires</strong> all students taking 12 credits undergraduate or 9 hours graduate study to have adequate health insurance coverage. SUNY requires all international students &amp; scholars to carry adequate medical coverage. All students (Domestic full-time and all international) covered under this university policy will automatically be charged for the University plan on the first qualifying tuition bill for the semester. All others who wish to enroll may do so by <a href='enroll.asp'>clicking here</a>.  Students who have adequate private coverage may waive the plan by providing proof of comparable coverage and submitting a waiver by the due date of their tuition bill for the semester. Comparable coverage must be in effect on or before the first day of classes.</p>
			
			<h3>Important Announcements:</h3>
			<p><strong>Notice about the Federal Health Care Reform Act of 2010:</strong> University Students registering for fall 2010 will not be affected and must maintain adequate coverage throughout the academic year. </p> 

		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/insurance/resources/includes/sidebar.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>
