<!-- #include virtual='/resources/libraries/util2.lib' -->

<%
	dim category: category = "Student Medical Insurance"
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual='/insurance/resources/includes/head.inc' -->
		
		<style type="text/css" media="screen">
			
			.enroll-waive-link a {
				
/*				display: inline-block;
				
				padding: 6px;
				border: 2px solid #133366;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				
				background: #275b99;
				background: -moz-linear-gradient(top, #194183, #133366);
				background: -webkit-gradient(linear, center top, center bottom, from(#194183), to(#133366));
				
				font-size: 2em;
				font-weight: bold;
				text-decoration: none;
				color: white;
				text-shadow: -2px -2px #133366;*/
			}
			
			.enroll-waive-link a:after {
			}
		</style>
	</head>
	<body>
		<!-- #include virtual='/insurance/resources/includes/header_new.inc' -->
		
		<div id='content'>
			
			<h2>General Information</h2>
<!--			<img src='/insurance/resources/images/departmentSmall1.gif'>
			
			<h3>University Policy for Health Insurance</h3>  -->
			<ul>
			<p><strong><font size ="4">Please Note: The University no longer generates a paper statement. Your Student Account Statement is by e-bill only.</font></strong>
				<!--<li>All students taking 12 credits undergraduate or 9 hours graduate study are required to have adequate health insurance coverage.</li>
				<li>SUNY requires all international students &amp; scholars to carry adequate medical coverage.</li>-->
				<li>The UB Student Medical Insurance Policy and premium is mandatory for attendance with qualified waiver only.</li>
				<li>The SUNY International Health Insurance Program and premium is mandatory for all international students &amp; scholars with qualified waiver only.</li>
			</ul>
			
			<h3>Waiving Health Insurance</h3>
			<p>The Window for Fall 2012 Waivers will open in mid-July.</p>
			<p>Waiving Health Insurance-Please see following pages to verify your private health insurance meets or exceeds the University at Buffalo requirements for attendance.</p> 

			<!--<p>The Spring only online waiver has ended as of Feb. 22, 2012.   Our late-waiver period will be available until March 20, 2012 for students who were billed for insurance on February 7, 2012.  Waiver packets can be picked up in the Student Medical Insurance Office 223 Student Union.</p> -->
			<!--<br>
			<p class='big-important-link'><a href='domestic_waive.asp'>Domestic Student Insurance Waiver</a></p>-->
			<!--<p class='big-important-link'><a href='international_waive.asp'>International Student Insurance Waiver</a></p>-->
		
			<!--<br><p><font size="3" color="red">Fall 2011 Waiver Window expected to open shortly after July 11 and will remain open through October 2nd.</font></p>	-->	
			<h3>If you are a TA, GA, or RA</h3>
			
			<p>Teaching and graduate assistants are eligible for <abbr title='New York State Health Insurance Program'><a href='http://hr.buffalo.edu/gseu'>NYSHIP</a></abbr>; research assistants are eligible for <a href='http://hr.buffalo.edu/rfgrads'>POMCO</a>.  <strong>You will be automatically enrolled in the student health insurance until you attend your assistantship orientation. </strong>At that time there will be a departmental transmission which will remove the student health insurance fee from your student account. For more information <a href='taraga.asp'>click here</a>.</p>
			<p>If you are a teaching, research, or graduate assistant with <strong>your own private health insurance</strong>, please follow the waiver process for domestic or international students.</p>
			
		</div>
		
		<div id='secondary'>
			<p><font size=+1>Students</font></p>
			
			<h5><a href='new_students.asp'>New Students</a></h5>
			
			<h5><a href='domestic.asp'>Domestic Students</a></h5>
            
            <h5><a href='international.asp'>International Students, Scholars, and OPT</a></h5>
			
			<h5><a href='study_abroad.asp'>Study Abroad</a></h5>
			
			<h5><a href='taraga.asp'>Teaching, Research and Graduate Assistants</a></h5>
			
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>