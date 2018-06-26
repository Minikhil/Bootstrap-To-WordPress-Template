<!-- #include virtual='/resources/libraries/util2.lib' -->
<%
	import "DataModel"
	import "Form"
	
	dim category, subcategory
	
	xprintf "zo%#.0fmg%%%d", Array(4200, 43, 44, "lolwut?")
	
	xprintf "<br>%'+.7d", Array(12345)
%>


<%
	dim Apartment: set Apartment = DataModel()
	with Apartment
		.attribute "name", Str
		.attribute "address", Str
		.attribute "url", Str
		.attribute "phone", Str
		.attribute "description", Str
	end with
	
	dim f: set f = Form(Apartment)
%>


<%
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		dim apt: set apt = Apartment()
		
		print apt("name")
	end if
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<div class='table_layout_wrapper'>
			<ul id='categories'>
				<li class='category-search'><a href='index.asp'>Search</a></li>
				<li class='category-advertise'><a href='advertise.asp'>Advertise</a></li>
				<li class='category-roommates'><a href='roommates.asp'>Roommates</a></li>
				<li class='category-resources'><a href='resources.asp'>Resources</a></li>
				<li class='category-contact'><a href='contact.asp'>Contact Us</a></li>
			</ul>
		</div>
		
		<div id='content'>
			<h2>New Apartment Complex</h2>
			
			<form method='POST'>
				<div class='field text'>
					<label for="name">Name</label>
					<input type="text" name="name" value="<%= f.data()("name") %>" id="name">
				</div>
				
				<div class='field text'>
					<label for="address">Address</label>
					<input type="text" name="address" value="" id="address">
				</div>
				
				<div class='field text'>
					<label for="phone">Phone Number</label>
					<input type="phone" name="phone" value="" id="phone">
				</div>
				
				<div class='field text'>
					<label for="url">URL</label>
					<input type="text" name="url" value="" id="url">
				</div>
				
				<div class='field textarea'>
					<label for="description">Description</label>
					<textarea name="description" value="" id="description"></textarea>
				</div>
				
				<div class='field submit'>
					<input type="submit" name="submit" value="Submit" id="submit">
				</div>
			</form>
			
			<p class='disclaimer'><br>The SBI Off-Campus Housing Office does not investigate, endorse, or guarantee the accuracy of the information provided in any listing, the condition of the accommodation, or the suitability or performance of either the lister or any prospective tenant. Sub-Board I, Inc. or the University at Buffalo shall not be responsible for any loss or damage suffered or incurred by any individual or entity arising out of or relating to the listings. Sub-Board I, Inc. or the University at Buffalo shall not be deemed to be a party, and shall have no responsibility or obligation to enforce such agreement.</p>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>