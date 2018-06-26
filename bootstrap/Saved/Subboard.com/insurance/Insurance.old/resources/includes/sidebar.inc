<%
	function side_link(title, name)
		dim cur_cat: cur_cat = iff(inStr(Path.HERE.base, name) > 0, " class='current_category'")
		
		if Path.HERE.base = name then
			printf "<li id='current_page'%s><span>%s</span>", Array(cur_cat, title)
		else
			printf "<li%s><a href='%s.asp'><span>%s</span></a>", Array(cur_cat, name, title)
		end if
		set side_link = new SideLinkEphemeron
	end function
	
	class SideLinkEphemeron
		private sub class_terminate
			print "</li>"
		end sub
	end class
%>

<ul id='local_navigation'>
	<% side_link "Home", "index" %>
	
	<% with side_link("Domestic Students", "domestic") %>
		<ul>
			<% side_link "Benefits", "domestic_benefits" %>
			<% side_link "Enroll", "domestic_enroll" %>
			<% side_link "Waive", "domestic_waive" %>
			<% side_link "Providers", "domestic_providers" %>
			<% side_link "Dependents", "domestic_dependents" %>
			<% side_link "Insurance Prices", "domestic_prices" %>
		</ul>
	<% end with %>
	
	<% with side_link("International Students, Scholars, and OPT", "international") %>
		<ul>
			<% side_link "Benefits", "international_benefits" %>
			<% side_link "Enroll", "international_enroll" %>
			<% side_link "Waive", "international_waive" %>
			<% side_link "OPT Participants", "international_OPT" %>
			<% side_link "Providers & Referrals", "international_Providers" %>
			<% side_link "Insurance Prices", "international_prices" %>
		</ul>
	<% end with %>
	
	<% side_link "Study Abroad", "study_abroad" %>
	
	<% side_link "Teaching, Research, and Graduate Assistants", "taraga" %>
</ul>