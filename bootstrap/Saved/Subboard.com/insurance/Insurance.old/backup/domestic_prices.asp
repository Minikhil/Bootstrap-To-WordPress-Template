<!-- #include virtual='/resources/libraries/util2.lib' -->

<%
	dim category: category = "Prices"
%>

<!-- #include virtual='/resources/includes/doctype.inc' -->

<html lang='en-us'>
	<head>
		<!-- #include virtual='/insurance/resources/includes/head.inc' -->
	</head>
	<body>
		<!-- #include virtual='/insurance/resources/includes/header.inc' -->
		
		<div id='content'>
			<h2>Domestic Insurance Prices</h2>
			
			<table class='prices'>
				<tr>
					<td></td>
					<th>Period of coverage</th>
					<th>Premium for student only</th>
					<th>Premium to add dependent spouse</th>
					<th>Premium to add dependent children</th>
				</tr>
				<tr>
					<th>Domestic students</th>
					<td>8/22/12-8/21/13</td>
					<td>$2,084.00</td>
					<td>$4,661.00</td>
					<td>$3,630.00</td>
				</tr>
			<!--	<tr>
					<th>Domestic students (medical, dental, or nursing)*</th>
					<td>8/22/10 &ndash; 8/21/11</td>
					<td>$1,880.00</td>
					<td>$4,207.00</td>
					<td>$3,275.00</td>
				</tr>-->
			</table>
			<!--<p>(*majors as defined by registration codes)-->
		</div>
		
		<div id='secondary'>
			<!-- #include virtual='/insurance/resources/includes/sidebar.inc' -->
		</div>
		
		<!-- #include virtual='/resources/includes/bottom_navigation_new.inc' -->
	</body>
</html>
