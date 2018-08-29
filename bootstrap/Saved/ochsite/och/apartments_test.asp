<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Apartments"
	
	Dim db: Set db = Server.CreateObject("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim apartments: Set apartments = Server.CreateObject("adodb.recordset")
	apartments.Open "select [name], [listing_id], [phone], [image_id], [description], [url], [address]" & _
	                "from [ApartmentComplexes] " & _
	                "order by [name]", db
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
		
		<style type='text/css' media='screen'>
			#apartments .headers, #apartments .apartment {
				overflow: auto;
				width: 100%
			}
			
			#apartments span {
				float: left;
			}
			
			#apartments .headers {
				font-weight: bold;
			}
			
			#apartments .name {width: 40%;}
			#apartments .address {width: 40%;}
			#apartments .phone {width: 20%;}
			
			#enhanced .apartment {
				overflow: hidden;
				position: relative;
				margin-top: 1em
			}
			
			#enhanced img {
				display: block;
				width: 187px;
				height: 125px;
				background: #aaa;
				float: right;
				margin-left: 10PX
			}
			
			#enhanced .block_link {
				position: absolute;
				display: block;
				left: 0;
				right: 0;
				top: 0;
				bottom: 0;
				text-indent: -9001px;
				z-index: 10;
			}
		</style>
		
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		
		<div id='content'>
			<h2>List of Local Apartment Complexes</h2>
			
			<!-- <h3>Featured</h3> -->
			
			<div id='enhanced'>
<%	do until apartments.eof %>
				<div class='apartment'>
					<h3 class='name'><%= apartments("name") %></h3>
					<a href='/och/resources/images/listing_images/<%= apartments("image_id") %>.jpg'><img src='/och/resources/images/listing_images/<%= apartments("image_id") %>.jpg'></a>
					<div class='address'><%= apartments("address") %>   </div>
					<div class='phone'><%= apartments("phone") %></div>
					<a href='<%= apartments("url") %>'><%= apartments("url") %></a>
					<p class='description'><%= apartments("description") %></p>
				</div>
<%	apartments.MoveNext: loop %>
			</div>
			
			<p><a href='apartment_listings_faq.asp'>About these listings</a></p>
			
			<p class='disclaimer'><br>The SBI Off-Campus Housing Office does not investigate, endorse, or guarantee the accuracy of the information provided in any listing, the condition of the accommodation, or the suitability or performance of either the lister or any prospective tenant. Sub-Board I, Inc. or the University at Buffalo shall not be responsible for any loss or damage suffered or incurred by any individual or entity arising out of or relating to the listings. Sub-Board I, Inc. or the University at Buffalo shall not be deemed to be a party, and shall have no responsibility or obligation to enforce such agreement.</p>
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>