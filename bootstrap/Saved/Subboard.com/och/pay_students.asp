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
			
			<h3>Current UB Students</h3>
			
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
				<dl>
					<dt>Listing Cost: Free</dt>
					<dd>
						<a href='http://www.wings.buffalo.edu/subboard/och?listing_id=<%= id %>'>Verify student status</a>
						<br><br>
					</dd>
					
					<!--<dt>Additional Listing: $10</dt>
					<dd>
						<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
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
						<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
							<input type="hidden" name="cmd" value="_xclick">
							<input type="hidden" name="business" value="ochstaff@buffalo.edu">
							<input type="hidden" name="item_name" value="Renew Listing - Student">
							<input type="hidden" name="amount" value="10.00">
							<input type="hidden" name="return" value="http://subboard.com/och/confirm_payment.asp?id=<%= id %>">
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