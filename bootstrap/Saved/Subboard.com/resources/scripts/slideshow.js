var TIME_VISIBLE = 5000;
var TIME_STEP = 20;
var OPACITY_STEP = .02;

function setOpacity(element, opacity)
{
	element.style.opacity = opacity; // Standard
	element.style.MozOpacity = opacity; // Old Gecko
	element.style.KhtmlOpacity = opacity; // Old KHTML / WebKit
	element.style.filter = "alpha(opacity=" + opacity * 100 + ")"; // IE
}

function slideshow()
{
	// Note on z-indices: The z-index of inactive images is 0. A fading image is 2 and a stable displayed image is 1.
	// Z-indices are used instead of display:none so that all images will load immediately.
	
	// Set up news_items array.
	var news = document.getElementById("news");
	var news_items = Array();
	for (var current = news.firstChild; // Fill array with news items.
		current != null;
		current = current.nextSibling)
	{
		if (current.nodeType == 1 && current.className == "item")
		{
			news_items.push(current);
		}
	}
	
	// Declare variables for the swap_image closure.
	var i = 0;
	var current_item;
	var next_item;
	var current_image;
	var next_image;
	
	next_item = news_items[0];
	for (next_image = next_item.firstChild; // Find image.
		!((next_image.nodeType == 1) && (next_image.tagName == "A"));
		next_image = next_image.nextSibling) {}
		next_image = next_image.firstChild;
	
	var swap_image = function()
	{
		// Move to next news item.
		i = (i + 1) % news_items.length;
		current_item = next_item;
		current_image = next_image;
		next_item = news_items[i];
		for (next_image = next_item.firstChild; // Find image.
			!((next_image.nodeType == 1) && (next_image.tagName == "A"));
			next_image = next_image.nextSibling) {}
		next_image = next_image.firstChild;
		
		// These variables are used in the fade_step closure.
		var opacity = 1;
		var intervalID;
		var fade_step = function()
		{
			opacity -= OPACITY_STEP;
			if (opacity > 0)
			{
				setOpacity(current_image, opacity)
			}
			else
			{
				clearInterval(intervalID);
				current_image.style.zIndex = 0;
				setOpacity(current_image, 1);
			}
		}
		
		// Execute fade.
		current_item.id = "";
		next_item.id = "current_news_item";
		current_image.style.zIndex = 2;
		next_image.style.zIndex = 1;
		
		intervalID = setInterval(fade_step, TIME_STEP);
	}
	
	// Begin swap_image "loop".
	setInterval(swap_image, TIME_VISIBLE);
}