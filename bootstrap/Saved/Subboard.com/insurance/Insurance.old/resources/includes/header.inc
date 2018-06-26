<%
	function current (cat)
		if category = cat then
			print "class='current'"
		end if
	end function
%>

		<div id='header'>
			<div class='accessibility'><a href='#content' >Skip to content</a></div>
			
			<form id='search' action='http://search.buffalo.edu/search'>
				<div><label for='q' class='accessibility'>Search</label><input type='text' name='q' id='q'></div>
				<div><input type='image' name='search-submit' value='Search' src='/resources/images/magnifying_glass.png' id='search-submit'></div>
				
				<div>
					<input type="hidden" name="client" value="UB">
					<input type="hidden" name="proxystylesheet" value="UB">
					<input type="hidden" name="output" value="xml_no_dtd">
					<input type="hidden" name="site" value="UB">
					<input type="hidden" name="as_sitesearch" value="http://subboard.com/insurance">
				</div>
			</form>
			
			<div class='clear'></div>
			
			<h1><a href='/index.asp'>SBI Student-Owned Services</a></h1>
			
			<h2>Student Medical Insurance</h2>
		</div>
		
		<ul id='categories'>
			<li class='category-home'><a href='index.asp' <% current "Home" %>>Home</a></li>
			<li class='category-forms'><a href='forms.asp' <% current "Forms" %>>Forms</a></li>
			<li class='category-deadlines'><a href='deadlines.asp' <% current "Deadlines" %>>Deadlines</a></li>
			<li class='category-faq'><a href='new_students.asp' <% current "New Students" %>>New Students</a></li>
			<li class='category-contact'><a href='contact.asp' <% current "Contact" %>>Contact</a></li>
		</ul>
