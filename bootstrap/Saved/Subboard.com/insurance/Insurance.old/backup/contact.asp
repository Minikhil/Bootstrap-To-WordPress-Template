<!-- #include virtual='/resources/libraries/util2.lib' -->

<%
	dim category: category = "Contact"
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual='/insurance/resources/includes/head.inc' -->
	</head>
	<body>
		<!-- #include virtual='/insurance/resources/includes/header.inc' -->
		
		<div id='content'>
			<h2>Contact</h2>
			
			<div class='vcard'>
				<h4 class='fn org'>Student Medical Insurance</h4>
				
				<div class='adr'>
					<div class='street-address'>Student Union, Suite 223</div>
					<div class='extended-address'>Box 602100, University at Buffalo</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14260-2100</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 645-3036</span></div>
				<div class='tel'><span class='type'>Fax</span>: <span class='value'>(716) 645-3465</span></div>
				<div>Email: <span class='email'><a href='mailto:asksmi@buffalo.edu'>asksmi@buffalo.edu</a></span></div>
				
				<div class='note'>Open Mon&ndash;Fri, 9 AM&ndash;4 PM</div>
			</div>
			
			<ul>
				<li><a href='#aetna_student_health'>Aetna Student Health</a></li>
				<li><a href='#campus_pharmacy'>Campus Pharmacy</a></li>
				<li><a href='#counseling_services'>Counseling Services</a></li>
				<li><a href='#health_education'>Health Education</a></li>
				<li><a href='#health_services'>Health Services</a></li>
				<li><a href='#hth_worldwide'>HTH Worldwide</a></li>
				<li><a href='#university_police'>University Police</a></li>
				<li><a href='#wellness_education'>Wellness Education</a></li>
			</ul>
			
			<h3>On-Campus Health Services</h3>
			
			<div class='vcard'>
				<h4 class='fn org' id='campus_pharmacy'>Campus Pharmacy</h4>
				<ul>
					<li>Full range prescription service</li>
					<li>Name brand &amp; generic over-the-counter medicine</li>
					<li>Pharmacist consultation</li>
				</ul>
				
				<div class='adr'>
					<div class='street-address'>Michael Hall</div>
					<div class='extended-address'>University at Buffalo South Campus</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14214</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 829-2368</span></div>
				<div><a class='url' href='http://www.subboard.com/pharmacy'>www.subboard.com/pharmacy</a></div>
			</div>
			
			<div class='vcard' id='counseling_services'>
				<h4 class='fn org'>Counseling Services</h4>
				<div>Mental health, wellness, and safety</div>
				
				<div class='adr'>
					<div class='street-address'>120 Richmond Quad</div>
					<div class='extended-address'>University at Buffalo North Campus, Elicott Complex</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14261</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 645-2175</span></div>
				<div><a class='url' href='http://ub-counseling.buffalo.edu'>ub-counseling.buffalo.edu</a></div>
			</div>
			
			<div class='vcard' id='health_education'>
				<h4 class='fn org'>Health Education</h4>
				<ul>
					<li>Sexuality and Sexual Health</li>
					<li>Safety Shuttle and Walk Stations</li>
				</ul>
				
				<div class='adr'>
					<div class='street-address'>414 Michael Hall</div>
					<div class='extended-address'>University at Buffalo South Campus</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14214</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 829-2584 </span></div>
				<div class='email'>Email: <a href='mailto:sbi-healthed@buffalo.edu'>sbi-healthed@buffalo.edu</a></div>
				<div class='url'><a href='http://HealthEducation.buffalo.edu'>HealthEducation.buffalo.edu</a></div>
				
			</div>
			
			<div class='vcard' id='health_services'>
				<h4 class='fn org'>Health Services</h4>
				<ul>
					<li>Primary Care</li>
					<li>Women’s Health Clinic</li>
					<li>Infections Disease Clinic</li>
					<li>Immunization Clinic</li>
					<li>RN Health Screenings</li>
					<li>Travel Clinic</li>
					<li>Chiropractic Care</li>
					<li>Nutrition</li>
					<li>Eating Disorders Team</li>
					<li>HIV Testing &amp; Counseling</li>
					<li>Sexually Transmitted Infection Screening</li>
					<li>Pregnancy Testing</li>
					<li>Dental Care at UB</li>
					<li>Sports Medicine</li>
				</ul>
				
				<div class='adr'>
					<div class='street-address'>Michael Hall</div>
					<div class='extended-address'>University at Buffalo South Campus</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14214</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 829-3316</span></div>
				<div class='url'><a href='http://www.student-affairs.buffalo.edu/shs/student-health/'>www.student-affairs.buffalo.edu/shs/student-health/</a></div>
			</div>
			
			<div class='vcard' id='university_police'>
				<h4 class='fn org'>University Police</h4>
				
				<div class='adr'>
					<div class='street-address'>Bissell Hall</div>
					<div class='extended-address'>University at Buffalo North Campus</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14260</span>
					</div>
				</div>
				
				<div class='tel'>Emergencies: <span class='value'>(716) 645-2222</span></div>
				<div class='tel'>Non-emergencies: <span class='value'>(716) 645-2227</span></div>
			</div>

			<div class='vcard' id='wellness_education'>
				<h4 class='fn org'>Wellness Education</h4>
				<ul>
					<li>Alcohol, Tobacco, & Other Drug Education</li>
					<li>LGBTQ @ UB</li>
					<li>Healthy Eating</li>
					<li>Stress Reduction</li>
					<li>Rape and Sexual Assault Prevention</li>
				</ul>
				
				<div class='adr'>
					<div class='street-address'>114 Student Union</div>
					<div class='extended-address'>University at Buffalo North Campus</div>
					<div>
						<span class='locality'>Buffalo</span>,
						<abbr class='region' title='New York'>NY</abbr>
						<span class='postal-code'>14260</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(716) 645-2837</span></div>
				<div class='url'><a href='http://www.student-affairs.buffalo.edu/shs/wes/'>www.student-affairs.buffalo.edu/shs/wes/</a></div>
			</div>

			
			<h3>Insurance Providers</h3>
				
			<div class='vcard' id='hth_worldwide'>
				<h4 class='fn org'>HTH Worldwide</h4>
				<div class='note'>International student insurance provider</div>
				
				<div class='adr'>
					<div class='street-address'>One Radnor Corporate Center</div>
					<div class='extended-address'>Suite 100</div>
					<div>
						<span class='locality'>Radnor</span>,
						<abbr class='region' title='Pennsylvania'>PA</abbr>
						<span class='postal-code'>19087</span>
					</div>
				</div>
				
				<div class='tel'>Customer Service: <span class='value'>(877) 424-4352</span></div>
				<div class='tel'>Inbound Student Plans: <span class='value'>(888) 350-2002</span></div>
				<div class='tel'>Outside the U.S./Study Abroad plans: <span class='value'>(888) 243-2358</span></div>
				<div><a class='url' href='http://www.hthstudents.com'>www.hthstudents.com</a></div>
			</div>
			
			<div class='vcard' id='aetna_student_health'>
				<h4 class='fn org'>Aetna Student Health</h4>
				<div class='note'>Domestic student insurance provider</div>
				
				<div class='adr'>
					<div class='street-address'>One Charles Park</div>
					<div>
						<span class='locality'>Cambridge</span>,
						<abbr class='region' title='Massachusetts'>MA</abbr>
						<span class='postal-code'>02142-1254</span>
					</div>
				</div>
				
				<div class='tel'>Phone: <span class='value'>(800) 954-5793</span></div>
				<div><a class='url' href='http://www.aetnastudenthealth.com'>www.aetnastudenthealth.com</a></div>
			</div>
		
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/insurance/resources/includes/sidebar.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>
