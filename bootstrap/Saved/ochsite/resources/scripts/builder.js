function elem() {
	var e = document.createElement(arguments[0]);
	
	function callOnElem (f) {
		return function () {
			f.apply(e, arguments);
		};
	}
	
	for (var i=1; i<arguments.length; i++) {
		var arg = arguments[i];
		var type = typeof arg;
		var type2 = type;
		if (type === 'object') {
			if (arg.nodeType) {type2 = 'node';}
			else if (arg.constructor && arg.constructor.toString().match(/^function String\(/i)) {type2 = 'string';}
		}
		switch (type2) {
			case 'object':
				for (var attr in arg) {
					if (typeof arg[attr] === 'function') {
						e[attr] = callOnElem(arg[attr]);
					}
					else if (attr === 'klass') {e.className = arg[attr];} // IE doesn't like setAttribute with class AND thinks that 'class' is a keyword!
					else {e.setAttribute(attr, arg[attr]);}
				}
				break;
			case 'string':
				var t = document.createTextNode(arg);
				e.appendChild(t);
				break;
			case 'node':
				e.appendChild(arg);
				break;
			case 'function':
				arg.apply(e);
				break;
		}
	}
	
	return e;
}

function elemFromHTML() {
	var e = document.createElement(arguments[0]);
	
	function callOnElem (f) {
		return function () {
			f.apply(e, arguments);
		};
	}
	
	for (var i=1; i<arguments.length; i++) {
		var arg = arguments[i];
		var type = typeof arg;
		var type2 = type;
		if (type === 'object') {
			if (arg.constructor && arg.constructor.toString().match(/^function String\(/i)) {type2 = 'string';}
		}
		switch (type2) {
			case 'object':
				for (var attr in arg) {
					if (typeof arg[attr] === 'function') {
						e[attr] = callOnElem(arg[attr]);
					}
					else if (attr === 'klass') {e.className = arg[attr];} // IE doesn't like setAttribute with class AND thinks that 'class' is a keyword!
					else {e.setAttribute(attr, arg[attr]);}
				}
				break;
			case 'string':
				e.innerHTML = e.innerHTML + arg;
				break;
		}
	}
	
	return e;
}

function $(id) {
	return document.getElementById(id);
}