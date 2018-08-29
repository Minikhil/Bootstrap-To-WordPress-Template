<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Pay for listing"
	
	Dim db: Set db = Server.CreateObject("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim id: id = Param("id")
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<style type='text/css'>
			.listing_given, .no_listing {
				display: none;
			}
			
			#listing_given .listing_given, #no_listing .no_listing {
				display: block;
			}
			
			dt {width: 30% !important}
			dd {width: 70% !important}
			
			.large_options {list-style: none; line-height: 2.5em; font-size: 1.5em;}
		</style>
	</head>
	<body id='<%= iif(id <> "", "listing_given", "no_listing") %>'>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>Pay for listing <%= id %></h2>
			
			<div class='no_listing'>
				<form method='get'>
					<div class='field'>
						<label for='id'>Listing ID</label>
						<input type='text' name='id' id='id'>
					</div>
					
					<div class='field'>
						<input type='submit' value='Submit'>
					</div>
				</form>
			</div>
			
			<div class='listing_given'>
				<p>Please select one of the following:</p>
				
				<ul class='large_options'>
					<!--<li><a href='pay_nonstudents.asp?id=<%= id %>'>I am <strong>not</strong> a UB student.</a></li>-->
<li><a href='https://www.sbiticket.buffalo.edu/DisplayGenAdmin.aspx?ScheduleID=38578'>I am <strong>not</strong> a UB student.</a></li>
					<li><a href='pay_students.asp?id=<%= id %>'>I am a UB student.</a></li>
				</ul>
				
				<!-- <h3>Students</h3>
				<dl>
					<dt>First Listing: Free</dt>
					<dd>
						<a href='http://www.wings.buffalo.edu/subboard/och?listing_id=<%= id %>'>Verify student status</a>
						<br><br>
					</dd>
					
					<dt>Additional Listing: $10</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Additional Listing - Student">
							<input type="hidden" name="amount" value="10.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
					
					<dt>Renew Listing: $10</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Renew Listing - Student">
							<input type="hidden" name="amount" value="10.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
				</dl>
				
				<h3>Non-Students</h3>
				
				<dl>
					<dt>First Listing: $25</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="First Listing - Non-Student">
							<input type="hidden" name="amount" value="25.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
					
					<dt>Additional Listing: $20</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Additional Listing - Non-Student">
							<input type="hidden" name="amount" value="20.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
					
					<dt>Renew Listing: $15</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Renew Listing - Non-Student">
							<input type="hidden" name="amount" value="15.00">
							<input type="hidden" name="return" value="http://subboard.com/och/pay.asp">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
				</dl> -->
			</div>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>