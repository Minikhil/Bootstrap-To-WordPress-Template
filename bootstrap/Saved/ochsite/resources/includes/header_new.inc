<!-- #include virtual=/resources/scripts/random_images.asp -->
		<div id='header'>
			<div class='accessibility'><a href='#content' >Skip to content</a></div>
			
			<form id='search' action='http://search.buffalo.edu/search'>
				<div><label for='q' class='accessibility'>Search</label><input type='text' name='q' id='q' placeholder='Search subboard.com'></div>
				<div><input type='image' name='search-submit' value='Search' src='/resources/images/magnifying_glass.png' id='search-submit'></div>
				
				<div>
					<input type="hidden" name="client" value="UB">
					<input type="hidden" name="proxystylesheet" value="UB">
					<input type="hidden" name="output" value="xml_no_dtd">
					<input type="hidden" name="site" value="UB">
					<input type="hidden" name="as_sitesearch" value="http://subboard.com">
				</div>
			</form>
			
			<!-- <a href='#' id='facebook_link'><span class='n1'>Find us on</span> <span class='n2'>Facebook</span></a> -->
			
			<div class='clear'></div>
			
			<h1><a href='/index.asp'>SBI Student-Owned Services</a></h1>
			
			<div id='random_images'>
				<img src='/resources/images/random_images/<% print image1 %>' alt='random image'>
				<img src='/resources/images/random_images/<% print image2 %>' alt='random image'>
				<img src='/resources/images/random_images/<% print image3 %>' alt='random image'>
			</div>
		</div>