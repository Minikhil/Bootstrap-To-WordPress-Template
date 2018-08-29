<!-- #include virtual='/resources/libraries/util2.lib' -->
<%
	dim category: category = "Forms"
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual='/insurance/resources/includes/head.inc' -->
		
		<style type="text/css" media="screen">
			li:target {
				background: #ff9;
			}
		</style>
	</head>
	<body>
		<!-- #include virtual='/insurance/resources/includes/header.inc' -->
		
		<div id='content'>
			<h2>Insurance Forms &amp; Documents</h2>
			
			<!--
			<ul>
				<li><a href='#domestic_enrollment'>Enrollment (Undergrad, Grad, Professional)</a></li>
				<li><a href='#domestic_enrollment_medical'>Enrollment (Medical, Dental, Nursing)</a></li>
				
				<li><a href='#international_enrollment'>International Enrollment</a></li>
				<li><a href='#international_dependent_enrollment'>International Dependent Enrollment</a></li>
				<li><a href='#international_waiver'>International Waiver</a></li>
				<li><a href='#j1-j2_waiver'>J-1 Scholar and J-2 Dependent Waiver</a></li>
				<li><a href='#international_clarification_of_benefits'>International Clarification of Insurance Benefits</a></li>
				<li><a href='#opt_enrollment'>OPT Enrollment</a></li>
				
				<li><a href='#medex_brochure'>MEDEX Brochure</a></li>
				<li><a href='#medex_enrollment'>MEDEX Enrollment</a></li>
				<li><a href='#study_abroad_waiver'>Study Abroad Waiver</a></li>
				<li><a href='#study_abroad_brochure'>Study Abroad Insurance Benefits Brochure</a></li>
			</ul> -->
			
			<h3>Domestic Student Insurance</h3>
			<ul>
				<li id='domestic_brochure'><a href='forms/2012-2013/domestic/brochure1213.pdf'> 2012 &ndash; 2013 Student Health Insurance Plan Brochure</a></li>
				<li id='parttime_domestic_enrollment'><a href='forms/2012-2013/2012-13DomesticEnrollment.pdf'>2012 &ndash; 2013 Part-Time Enrollment Form for Students/Dependents(Undergrad/grad/professional)</a></li>
				
			</ul>
			
			<h3>International Student Insurance</h3>
			<ul>
				<li id='international_enrollment'><a href='forms/2012-2013/international/InternationalEnrollmentForm.pdf'>2012 &ndash; 2013 International Student Enrollment Form</a></li>
				<!--<li id='international_dependent_enrollment'><a href='forms/2010-2011/international/SUNYDependentEnrollmentForm2010.pdf'>2010 &ndash; 2011 International Dependent Enrollment</a></li>-->
				<li id='international_medex_enrollment'><a href='forms/2012-2013/international/MEDEXEnrollment201213.pdf'>2012 &ndash; 2013 MEDEX Enrollment Form</a></li>
				<li id='j1-j2_waiver'><a href='forms/2012-2013/international/J-1J-2WAIVER1112.pdf'>2012 &ndash; 2013 J-1 and J-2 Waiver Form</a></li>
				<li id='international_waiver'><a href='forms/2012-2013/international/InternationalWaiverForm.pdf'>2012 &ndash; 2013 International Waiver Form</a></li>
				<li id='international_waiver'><a href='forms/2012-2013/international/DependentEnrollmentForm2012.pdf'>2012 &ndash; 2013 SUNY Dependent Enrollment Form</a></li>
			</ul>
			
			<h3>Study Abroad</h3>
			<ul>
				<li id='sa_enrollment'><a href='forms/2012-2013/international/HTHStudyAbroadEnrollment.pdf'>2012 &ndash; 2013 HTH Study Abroad Enrollment</a></li>
				<li id='medex_enrollment'><a href='forms/2012-2013/international/MEDEXEnrollment201213.pdf'>2012 &ndash; 2013 MEDEX Enrollment</a></li>
				<li id='study_abroad_waiver'><a href='forms/2010-2011/study_abroad/Study_Abroad_Waive.pdf'>Study Abroad Waiver</a></li>
				<!--<li id='study_abroad_brochure'>2010 &ndash; 2011 HTH Study Abroad Insurance Brochure (not yet available)</li>-->
				<li id='medex_brochure'>2011 &ndash; 2012 MEDEX Policy Brochure (not yet available)</li>
				<br>
			</ul>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/insurance/resources/includes/sidebar.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>
