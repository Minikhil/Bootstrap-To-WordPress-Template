/* Prepares questions lists by wrapping dt text inside an anchor with a toggle funcion and putting ids on dd elements.
 * This could be done more easily in the markup, but now all you have to do is label a dl as class='questions'.
 * No javascript, no problem -- you just see everything unfolded, no links or ids.
 */
function prepareQuestions () {
	var dls = document.getElementsByTagName("dl");
	
	for (var i = 0 ; i < dls.length ; i++) {
		if (dls[i].className.match("questions")) {
			var children = dls[i].childNodes;
			var element_num = 0;
			
			for (var j = 0 ; j < children.length ; j ++) {
				var id = "answer-" + i + "-" + element_num;
				
				if (children[j].nodeName == "DT") { // Insert an anchor around the contents of the dt.
					
					var text = children[j].firstChild;
					var newContent = document.createElement("a");
					newContent.setAttribute("href", "javascript: toggle(\"" + id + "\");");
					newContent.setAttribute("title", "Show or hide the answer");
					newContent.appendChild(text);
					children[j].appendChild(newContent);
				}
				else if (children[j].nodeName == "DD") { // Give the dd an id.
					children[j].id = id;
					children[j].className = "hidden";
					element_num++;
				}
			}
		}
	}
}

function toggle (id) {
	var element = document.getElementById(id);
	element.className = (element.className == "hidden") ? "" : "hidden";
}

function scrollToRightPlace () {
	var loc = location.hash;
	if (loc) {
		var element = document.getElementById(loc.substring(1)); // Substring skips the octothorpe
		var y = 0;
		while (element != null) { // Credit for this loop to http://radio.javaranch.com/pascarello/2005/01/09/1105293729000.html
			y += element.offsetTop;
			element = element.offsetParent;
		}
		window.scrollTo(0, y);
	}
}

function add_onload (f) { // This will clobber existing onloads that are strings.
	var old = window.onload;
	window.onload = (typeof old == 'function') ? function () {old(); f()} : f;
}

// Say what you will about javascript; they got first-class functions right.
add_onload(prepareQuestions);
add_onload(scrollToRightPlace);