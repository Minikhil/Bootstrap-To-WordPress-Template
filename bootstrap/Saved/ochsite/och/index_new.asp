<!-- #include virtual='/och/resources/includes/initialize.inc' -->

<!-- #include virtual='/resources/includes/doctype.inc' -->

<%
	category = "Search"
	
	Dim db: Set db = Server.CreateObject ("adodb.connection")
	db.Provider = "Microsoft.Jet.OLEDB.4.0"
	db.Open DB_PATH
	
	Dim areas: Set areas = Server.CreateObject("adodb.recordset")
	areas.Open "select distinct [name] from [Localities] union select [name] from [Areas] order by [name]", db
	
	Dim streets: Set streets = Server.CreateObject("adodb.recordset")
	streets.Open "select [street] from [Streets] order by [street]", db
	
	Dim types: Set types = Server.CreateObject("adodb.recordset")
	types.Open "select [id], [unit_type] from [UnitTypes]", db
%>

<html lang='en-us'>
	<head>
		<!-- #include virtual=/och/resources/includes/head.inc -->
        <script type='text/javascript' src='js/jquery.js'></script>
        <script type='text/javascript' src='http://code.jquery.com/ui/1.10.3/jquery-ui.js'></script>
        <script type='text/javascript' src='js/jquery.simplemodal.js'></script>
        <script type='text/javascript' src='js/basic.js'></script>
        <link type='text/css' href='css/basic.css' rel='stylesheet' media='screen' />
        <link type='text/css' href='http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css' rel='stylesheet' media='screen' />
		<script type='text/javascript' charset='utf-8'>
			var legend;
			var options;
			
			function toggleMoreOptions () {
				legend.className = (legend.className == "toggle-off") ? "toggle-on" : "toggle-off"
				options.className = (options.className == "hidden") ? "" : "hidden";
			}
			
			function prepareMoreOptions () {
				var moreOptions = document.getElementById("more_options");
				options = document.createElement("div");
				
				var next;
				for (var child = moreOptions.firstChild; child != null; child = next) {
					next = child.nextSibling
					switch(child.nodeName) {
						case "SPAN":
							legend = child;
							legend.className = "toggle-on";
							legend.onclick = toggleMoreOptions;
							break;
						case "DIV":
							options.appendChild(child);
							break;
						case "FIELDSET":
							options.appendChild(child);
							break;
					}
				}
				moreOptions.appendChild(options);
				options.setAttribute("style", "background: #eee");
				toggleMoreOptions();
			}
			
			<% OnLoad("prepareMoreOptions") %>
		</script>
		
		<style type='text/css'>
			.toggle-on, .toggle-off {
				cursor: pointer;
				
				padding-right: 10px;
				background-repeat: no-repeat;
				background-position: 100% 60%;
			}
			
			.toggle-off {
				background-image: url("/och/resources/images/disclosure_triangle_closed.png");
			}
			
			.toggle-on {
				background-image: url("/och/resources/images/disclosure_triangle_open.png");
			}
            
            .float-right {
                float: right;
            }
            
            .float-left{
                float: left;
            }
            
            .center{
                text-align: center;
            }
		</style>
	</head>
	<body>
		<!-- #include virtual=/och/resources/includes/header.inc -->
		
		<!-- #include virtual=/och/resources/includes/categories.inc -->
		<div id='content'>
			<h2>Search</h2>
			
			<form id='och_search' action='search.asp'>
				<fieldset>
					<fieldset class='sub_options'>
						<div class='legend'>Rent</div>
						<div class='field'>
							<label for='rent_min'>Min</label>
							<input type='text' name='rent_min' id='rent_min'>
						</div>
						<div class='field'>
							<label for='rent_max'>Max</label>
							<input type='text' name='rent_max' id='rent_max'>
						</div>
					</fieldset>
					
					<div class='field'>
						<label for='bedrooms_available'>Bedrooms Available</label>
						<input type='text' name='bedrooms_available' id='bedrooms_available'>
						<!-- <div class='sample'>(Or more)</div> -->
					</div>
					
					<div class='field'>
						<label for='area'>Area (<a href='resources.asp#areas'>about</a>)</label>
						<select name='area' id='area'>
							<option value=''>All Areas</option>
							<option></option> <!-- blank line -->
							
							<option>Allentown</option>
							<option>Buff State</option>
							<option>Downtown</option>
							<option>Elmwood</option>
							<option>North Buffalo/Hertel</option>
							<option>Parkside</option>
							<option>University Heights</option>
							<option>Amherst</option>
							<option>Tonawanda</option>
							<option></option> <!-- blank line -->
<%	do until areas.eof
%>							<option><%= areas("name") %></option>
<%	areas.MoveNext: loop %>
						</select>
					</div>
					
					<div class='field'>
						<label for='unit_type'>Unit Type</label>
						<select name='unit_type' id='unit_type'>
							<option value=''>All Types</option>
							<option></option> <!-- blank line -->
<%	do until types.eof
%>							<option value='<%= types("id") %>'><%= types("unit_type") %></option>
<%	types.MoveNext: loop %>
						</select>
					</div>
				</fieldset>
				
				<fieldset id='more_options'>
					<span class='legend'>More Options</span>
					
					<div class='field'>
						<label for='street'>Street</label>
						<select name='street' id='street'>
							<option value=''>Any</option>
<%	do until streets.eof
%>							<option><%= TitleCase(streets("street")) %></option>
<%	streets.MoveNext: loop %>
						</select>
					</div>
					
					<fieldset class='checkboxes'>
<%	Dim feature: for each feature in features_array %>
						<div class='field'>
							<input type='checkbox' name='features' value='<%= feature %>' id='feature-<%= feature %>'>
							<label for='feature-<%= feature %>'><%= Humanize(feature) %></label>
						</div>
<%	next %>
					</fieldset>
				</fieldset>
				
				<fieldset>
					<div class='field'>
						<button type='submit'>Search</button>
					</div>
				</fieldset>
			</form>
			
			<p>This listing service is for the sole use (and benefit) of students at the University at Buffalo.</p>
			<p><h2>DISCLAIMER:</h2> <p>This Website is Owned by Sub-Board I, Inc (SBI).</p> <p>SBI is not owned or operated by the University at Buffalo. SBI is a student-owned and operated not-for-profit corporation completely separate and distinct from the University at Buffalo. All information on this site is listed by SBI in its sole discretion. The University at Buffalo bears no responsibility for the content of this site.</p>
			<p>The SBI Off-Campus Housing Office does not investigate, inspect, endorse, or guarantee the accuracy of the information provided in any listing, the condition of the accommodation, or the suitability or performance of either the lister or any prospective tenant. SBI shall not be responsible for any loss or damage suffered or incurred by any individual or entity arising out of or relating to the listings. SBI shall not be deemed to be a party, and shall have no responsibility or obligation to enforce such agreement.</p>
			
			
			

		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/och/resources/includes/quick_links.inc' -->
		</div>
		
        <div style='display:none'>
			<img src='images/x.png' alt='' />
		</div>
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
        
        <div id="basic-modal-content">
		</div>
        
        <script type='text/javascript'>
            $div = $("#basic-modal-content");
            slide1();
            function slide1()
            {
                var htmlString = 
                        "<h2>Things to Remember While Searching</h2>"+
                        "<p>1. Rent is not your only cost.</p>"+
                        "<p>2. Location, location, location.</p>"+
                        "<p>3. Home safety is important.</p>"+
                        "<p>4. Neighborhood safety is important.</p>"+
                        "<p>5. How far away from campus is the housing?</p>"+
                        "<p><a href='#' onClick='readMore1();'>Read More ...</a></p>"+
                        "<input class='float-right' type='button' onClick='slide2();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
                $div.modal({autoResize: true});
            }
            
            function readMore1()
            {
                var htmlString = 
                        "<h2>Things to Remember While Searching</h2>"+
                        "<p>1. Rent is not your only cost.</p>"+
                        "<p><ul><li>Utilities, food, transportation, insurance, other costs</li></ul></p>"+
                        "<p>2. Location, location, location.</p>"+
                        "<p><ul><li>Where you live affects your expenses</li></ul></p>"+
                        "<p>3. Home safety is important.</p>"+
                        "<p>4. Neighborhood safety is important.</p>"+
                        "<p>5. How far away from campus is the housing?</p>"+
                        "<input class='float-right' type='button' onClick='slide2();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
                            
            function slide2()
            {
                var htmlString = 
                    "<h2>Types of Housing</h2>"+
                    "<p>There are two primary categories for housing:"+
                    "<ul><li>Complex Living - Multiple Unit Dwellings</li></ul>"+
                    "<ul><li>Standard Rental Homes - Usually 1-2 unit family homes</li></ul></p>"+
                    "<h2>Types of Apartments</h2>"+
                    "<p><ul><li>House Rentals</li></ul>"+
                    "<ul><li>Apartment/Flat Rentals</li></ul>"+
                    "<ul><li>Room Rentals</li></ul></p>"+
                    "<p><a href='#' onClick='readMore2();'>Read More ...</a></p>"+
                    "<input class='float-left' type='button' onClick='slide1();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide3();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function readMore2()
            {
                var htmlString = 
                        "<h2>Types of Housing</h2>"+
                        "<p>Complex Living"+
                        "<ul><li>Multiple unit dwellings</li>"+
                        "<li>Usually run by property management (building managers)</li>"+
                        "<li>Utilities & transportation are usually included with rent</li>"+
                        "<li>Staff is usually on hand and available</li>"+
                        "<li>Most complexes house similar lifestyles"+
                        "<li>Ex. Undergraduates, Graduates, Retirees, etc.</li></li></ul>"+
                        "<p>Standard Rental Homes</p>"+
                        "<ul><li>Usually 1-2 unit family homes</li>"+
                        "<li>Usually run by a landlord</li>"+
                        "<li>Utilities & transportation are not included with rent</li>"+
                        "<li>Landlords need advance notice to deal with housing issues</li>"+
                        "<li>Residential lifestyle usually requested</li></ul></p>"+
                        "<h2>Types of Apartment</h2>"+
                        "<p><ul><li>House Rentals - renting of the entire building</li>"+
                        "<li>Apartment/Flat Rentals - Renting one portion of a building</li>"+
                        "<li>Room Rentals - Renting of one specific bedroom with shared common areas in a unit</li></ul></p>"+
                        "<input class='float-left' type='button' onClick='slide1();' value='<< Prev' />"+
                        "<input class='float-right' type='button' onClick='slide3();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css({
                    "height":"400px",
                    "overflow-y":"auto"
                });
            }
            
            function slide3()
            {
                var htmlString = 
                    "<h2>Budgeting</h2>"+
                    "<p>1. Primary Costs</p>"+
                    "<p>2. Secondary Costs</p>"+
                    "<p><a href='#' onClick='readMore3();'>Read More ...</a></p>"+
                    "<input class='float-left' type='button' onClick='slide2();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide4();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function readMore3()
            {
                var htmlString = 
                    "<h2>Budgeting</h2>"+
                    "<p>Primary Costs"+
                    "<ul><li>Rent - Pay on time or addditional fees may be assessed</li>"+
                    "<li>Utilities - Monthly payments for heat, gas, electricity, or water</li>"+
                    "<li>Food - Meal plan? Cooking? Eating out?</li>"+
                    "<li>Transportation - Car? Bus? Walking? Biking? Etc.</li></ul></p>"+
                    "<p>Secondary Costs"+
                    "<ul><li>Laundry</li>"+
                    "<li>Insurance</li>"+
                    "<li>Furnishings</li>"+
                    "<li>Extracurricular</li>"+
                    "<li>Luxury Items</li></ul></p>"+                    
                    "<input class='float-left' type='button' onClick='slide2();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide4();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function slide4()
            {
                var htmlString = 
                    "<h2>Safety</h2>"+
                    "<p><u>You Are in Charge of Your Own Safety</u></p>"+
                    "<p>1. Have working smoke detectors</p>"+
                    "<p>2. Have working carbon monoxide detectors</p>"+
                    "<p>3. Make sure you have a working fire extinguisher and know how to operate it</p>"+
                    "<p>4. Know who to call in an emergency</p>"+
                    "<p>5. <a href='http://www.subboard.com/och/rental-checklist.pdf'>See Renter's Checklist</a></p>"+
                    "<p><a href='#' onClick='readMore4();'>Read More ...</a></p>"+
                    "<input class='float-left' type='button' onClick='slide3();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide5();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function readMore4()
            {
                var htmlString = 
                    "<h2>You Are In Charge Of Your Own Safety</h2>"+
                    "<p><ul><li>Smoke detectors are to be on every level of your home. They are to be in close proximity to every bedroom and in every room of the house</li>"+
                    "<li>Carbon monoxide detectors are to be located on every level where a carbon monoxide producer is located"+
                    "<li>Ex. Furnace, gas stove, etc.</li></li>"+
                    "<li>Make sure you have a fire extinguisher and know how to use it</li>"+
                    "<li>Know who to call in an emergency:"+
                    "<li>Police</li>"+
                    "<li>Fires</li>"+
                    "<li>Poison Control</li>"+
                    "<li><a href='http://www.subboard.com/och/municipality_contact.asp'>Municipality Contacts</a></li></li>"+
                    "<li>Lock doors and windows and leave an outside light on</li>"+
                    "<li>Do not travel alone, especially at night</li>"+
                    "<li>Never use a basement or an attic as a bedroom. They are traps in the event of a fire.</li>"+
                    "<li><a href='http://www.subboard.com/och/rental-checklist.pdf'>See Renter's Checklist</a></li></ul></p>"+
                    "<p>Most importantly, report any crime by calling 911 (Buffalo Police) or the E District Station at (716) 851-4416</p>"+                    
                    "<input class='float-left' type='button' onClick='slide3();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide5();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css({
                    "height":"400px",
                    "overflow-y":"auto"
                });
            }
            
            function slide5()
            {
                var htmlString = 
                    "<h2>Before Signing a Lease</h2>"+
                    "<p><h4><u>READ THE LEASE</u></h4></p>"+
                    "<p>Contact SBI Legal Assistance for free legal advice (716) 645-3056</p>"+
                    "<p><a href='#' onClick='readMore5();'>Read More ...</a></p>"+
                    "<input class='float-left' type='button' onClick='slide4();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide6();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function readMore5()
            {
                var htmlString = 
                    "<h2>Before Signing a Lease</h2>"+
                    "<p><h4><u>READ THE LEASE</u></h4></p>"+
                    "<p><ul><li>Contact SBI Legal Assistance for free legal advice (716) 645-3056</li>"+
                    "<li>Understand your responsibilities and your landlords' responsibilities</li>"+
                    "<li>Verbal promises won't hold up in court -- if you want something fixed before you move in, get it in writing</li>"+
                    "<li>Ask the owner to disclose any and all defects or damages with the house</li>"+
                    "<li>Some leases have a 'joint and several liability' caluse meaning the entire amount of rent is due each month no matter what (e.g., if your roommate moves out or can't pay, you will be held responsible). Make sure you find out before signing your lease and decide whether or not this is acceptable to you.</li>"+
                    "<li>Choose your roommates wisely; by signing your name to a lease, you may become liable/responsible for the actions of your roommates both criminally and with the University (Student-Wide Judiciary)</li>"+
                    "<li>Document (with photographs, camcorder, etc.) the condition of the entire house -- outside and in -- when you first move in, because your landlord may try to keep your security deposit for any damages that are present when you move out</li>"+
                    "<input class='float-left' type='button' onClick='slide4();' value='<< Prev' />"+
                    "<input class='float-right' type='button' onClick='slide6();' value='Next >>' />";
                $div.html(htmlString);
                $("#simplemodal-container").css("height","auto");
            }
            
            function slide6()
            {
                var htmlString = 
                    "<h2>For Your Information</h2>"+
                    "<p class='center'><u>Landlord VS Property Manager</u></p>"+
                    "<p><strong>Landlord</strong></p>"+
                    "<p><ul><li>Property owner</li></ul></p>"+
                    "<p><ul><li>Makes all final decisions</li></ul></p>"+
                    "<p><ul><li>Divides how lease is structured</li></ul></p>"+
                    "<p><strong>Property Manager</strong></p>"+
                    "<p><ul><li>Maintains units</li></ul></p>"+
                    "<p><ul><li>Can make decisions on behalf of landlords with their permission</li></ul></p>"+
                    "<p><ul><li>Enforces leases</li></ul></p>"+
                    "<p>There are housing laws which are specified by your <a href='http://subboard.com/och/municipality_contact.asp'>municipality</a> which are enforced by the building departments. Please contact them for further information. New York State mandates smoke detectors and carbon monoxide detectors in all forms of housing.</p>"+
                    "<p><a href='#' onClick='readMore6();'>Read More ...</a></p>"+
                    "<input class='float-left' type='button' onClick='slide5();' value='<< Prev' />"+
                    "<input class='float-right' type='button' id='closeBtn' value='Close' />";
                $div.html(htmlString);
                $("#closeBtn").click(function() {
                    $("#simplemodal-container").css("display","none");
                    $("#simplemodal-overlay").css("display","none");
                    $("#simplemodal-container").hide();
                    $("#simplemodal-overlay").hide();
                });
                $("#simplemodal-container").css({
                    "height":"400px",
                    "overflow-y":"auto"
                });
            }
            
            function readMore6()
            {
                var htmlString = 
                    "<h2>Be A Good Neighbor</h2>"+
                    "<p><ul><li>Get to know your neighbors -- they can be your most valuable resource</li>"+
                    "<li>Be responsibe. Keep noise down and keep your property clean</li>"+
                    "<li>Join a block club or visit a neighborhood center to learn how to help your neighborhood</li>"+
                    "</ul></p>" +
                    "<p><u>Insurance is cheap</u></p>" +
                    "<p><ul><li>If your belongings are stolen or destroyed in a fire, your landlord isn't responsible for replacing them. Renters insurance could save you thousands</li>"+
                    "<li>It costs as little as $12 a month</li>"+
                    "<li>Can cover fire, theft (from apartment as well as other places, such as the trunk of your car), liability claims (e.g. your dog bites someone or a guest falls at your apartment)</li>"+
                    "</ul></p>" +
                    "<p><u>Size Does Matter</u></p>" +
                    "<p>Review your apartment in comparison to the stuff you own</p>" +
                    "<p><ul><li>Not all beds fit up staircases and through all doors</li>"+
                    "<li>Not all living rooms can fit couches</li>" +
                    "<li>Larger apartments cost more to heat</li></ul></p>" +
                    "<p><u>Appliances</u></p>" +
                    "<p><ul><li>Stoves may run on gas or electric</li>" +
                    "<li>Dryers may run on gas or electric</li>" +
                    "<li>Look over all your appliances to make sure they are in working order (refridgerator, microwave, oven, stove, heaters, etc.)</li></ul></p>" +
                    "<input class='float-left' type='button' onClick='slide5();' value='<< Prev' />"+
                    "<input class='float-right' type='button' id='closeBtn' value='Close' />";
                $div.html(htmlString);
                $("#closeBtn").click(function() {
                    $("#simplemodal-container").css("display","none");
                    $("#simplemodal-overlay").css("display","none");
                    $("#simplemodal-container").hide();
                    $("#simplemodal-overlay").hide();
                });
                $("#simplemodal-container").css({
                    "height":"400px",
                    "overflow-y":"auto"
                });
            }
                        
        </script>
	</body>
</html>