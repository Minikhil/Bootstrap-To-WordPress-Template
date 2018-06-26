function go_to(dropdown)
{
	window.location = dropdown.options[dropdown.selectedIndex].value;
}

function remove_submit_button()
{
	document.getElementById("navigation_menu_submit").className = "hidden";
}