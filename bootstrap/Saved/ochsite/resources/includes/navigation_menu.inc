			<form method='get' action='/resources/scripts/redirect.asp' id='navigation_menu'>
				<div>
					<select id='destination' onchange='go_to(this.form.destination);'>
						<option value='http://www.subboard.com'>Student Owned Services</option>
						<option value='http://www.generation.buffalo.edu'>Generation</option>
						<option value='http://www.wrub.buffalo.edu'>WRUB</option>
						<option value='http://www.sbi-clinicalLab.buffalo.edu'>Clinical Lab</option>
						<option value='http://www.healtheducation.buffalo.edu'>Health Education</option>
						<option value='http://www.sbi-pharmacy.buffalo.edu'>Pharmacy</option>
						<option value='http://www.healthinsurance.buffalo.edu'>Student Medical Insurance</option>
						<option value='http://www.legalAssistance.buffalo.edu'>Legal Assistance</option>
						<option value='http://www.offCampusHousing.buffalo.edu'>Off-Campus Housing</option>
						<option value='http://www.sbi-ticketoffice.buffalo.edu'>Ticket Office</option>
					</select>
				</div>
				<div><input type='submit' value='Go' id='navigation_menu_submit'><script type='text/javascript'>remove_submit_button()</script></div>
				<!-- The above is far from pretty but better than having the button visible until the page loads. -->
			</form>