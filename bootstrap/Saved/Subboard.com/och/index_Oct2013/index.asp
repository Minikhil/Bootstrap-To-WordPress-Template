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
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>