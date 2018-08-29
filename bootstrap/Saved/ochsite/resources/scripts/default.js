function add_onload (f) {
	var old = window.onload;
	window.onload = (typeof old == 'function') ? function () {old(); f()} : f;
}

export add_onload;