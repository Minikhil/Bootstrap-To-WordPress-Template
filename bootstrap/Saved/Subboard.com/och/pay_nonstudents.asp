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
				<h3>Non-Students</h3>
				
				<dl>
					<!--<dt>First Listing: $30</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="First Listing - Non-Student">
							<input type="hidden" name="amount" value="30.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>-->
					
					<dt>Listing: $25</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Additional Listing - Non-Student">
							<input type="hidden" name="amount" value="25.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>
					
					<!--<dt>Renew Listing: $20</dt>
					<dd>
						<form action="https://tickets.subboard.com/DisplayGenAdmin.aspx?ScheduleID=30025" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Renew Listing - Non-Student">
							<input type="hidden" name="amount" value="20.00">
							<input type="hidden" name="return" value="http://subboard.com/och/pay.asp">
							<input type="hidden" name="currency_code" value="USD">
							<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
							<input type="hidden" name="custom" value="<%= id %>">
						</form>
					</dd>-->
				</dl>
			</div>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>