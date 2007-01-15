
/*****************************************/
/** Usable Forms 1.0, May 2003          **/
/** Written by ppk, www.quirksmode.org  **/
/** Instructions for use on my site     **/
/**                                     **/
/** You may use or change this script   **/
/** only when this copyright notice     **/
/** is intact.                          **/
/**                                     **/
/** If you extend the script, please    **/
/** add a short description and your    **/
/** name below.                         **/
/*****************************************/


var relatedTag = 'TR';

var compatible = (
	document.getElementById && document.getElementsByTagName && document.createElement
	&&
	!(navigator.userAgent.indexOf('MSIE 5') != -1 && navigator.userAgent.indexOf('Mac') != -1)
	);

if (compatible)
	document.write('<style>.accessibility{display: none}</style>');


function prepareForm()
{
	if (!compatible) return;
	var marker = document.createElement(relatedTag);
	marker.style.display = 'none';

	var x = document.getElementsByTagName(relatedTag);
	var toBeRemoved = new Array;
	for (var i=0;i<x.length;i++)
	{
		if (x[i].getAttribute('relation'))
		{
			var y = getAllFormFields(x[i]);
			x[i].nestedRels = new Array;
			for (var j=0;j<y.length;j++)
			{
				var rel = y[j].getAttribute('show');
				if (!rel || rel == 'none') continue;
				x[i].nestedRels.push(rel);
			}
			if (!x[i].nestedRels.length) x[i].nestedRels = null;
			toBeRemoved.push(x[i]);
		}
	}

	while (toBeRemoved.length)
	{
		var rel = toBeRemoved[0].getAttribute('relation');
		if (!document.getElementById(rel))
		{
			var newMarker = marker.cloneNode(true);
			newMarker.id = rel;
			toBeRemoved[0].parentNode.replaceChild(newMarker,toBeRemoved[0]);
		}
		document.getElementById('waitingRoom').appendChild(toBeRemoved.shift());
	}
	document.onclick = arrangeFormFields;

	var y = document.getElementsByTagName('input');
	for (var i=0;i<y.length;i++)
	{
		if (y[i].checked && y[i].getAttribute('show'))
			intoMainForm(y[i].getAttribute('show'))
	}

	var z = document.getElementsByTagName('select');
	
	// Opera weird with hidden selects in quirks mode: selectedIndex = -1
	
	for (var i=0;i<z.length;i++)
	{
		if (z[i].options[z[i].selectedIndex].getAttribute('show'))
		{
			z[i].onchange = arrangeFormFields;
			intoMainForm(z[i].options[z[i].selectedIndex].getAttribute('show'))
		}			
	}
}

function arrangeFormFields(e)
{
	if (!e) var e = window.event;
	var tg = (e.target) ? e.target : e.srcElement;
	if (
		!(tg.nodeName == 'SELECT' && e.type == 'change')
		&&
		!(tg.nodeName == 'INPUT' && tg.getAttribute('show'))
	   ) return;
	var toBeInserted = tg.getAttribute('show');

	/* Why no switch statement? Because Netscape 3 gives an error message on encountering it,
		and this script must degrade perfectly. */

	if (tg.type == 'checkbox')
	{
		if (tg.checked)
			intoMainForm(toBeInserted);
		else
			intoWaitingRoom(toBeInserted);
	}
	else if (tg.type == 'radio')
	{
		removeOthers(tg.form[tg.name],toBeInserted)
		intoMainForm(toBeInserted);
	}
	else if (tg.type == 'select-one')
	{
		toBeInserted = tg.options[tg.selectedIndex].getAttribute('show');
		removeOthers(tg.options,toBeInserted);
		intoMainForm(toBeInserted);
	}
}

function removeOthers(others,toBeInserted)
{
	var toBeRemoved = new Array;
	for (var i=0;i<others.length;i++)
	{
		var show = others[i].getAttribute('show');
		if (show != toBeInserted)
			toBeRemoved.push(show);
	}
	while (toBeRemoved.length)
		intoWaitingRoom(toBeRemoved.shift());
}

function gatherElements(name)
{
	var Elements = new Array;
	var x = document.getElementsByTagName(relatedTag);
	for (var i=0;i<x.length;i++)
		if (x[i].getAttribute('relation') == name)
			Elements.push(x[i]);
	return Elements;
}

function intoWaitingRoom(name)
{
	if (name == 'none') return;
	var Elements = gatherElements(name);
	if (isInWaitingRoom(Elements[0])) return;
	while (Elements.length)
	{
		if (Elements[0].nestedRels)
			for (var i=0;i<Elements[0].nestedRels.length;i++)
				intoWaitingRoom(Elements[0].nestedRels[i]);
		document.getElementById('waitingRoom').appendChild(Elements.shift())
	}
}

function intoMainForm(name)
{
	if (name == 'none') return;
	var Elements = gatherElements(name);
	if (!isInWaitingRoom(Elements[0])) return;
	var insertPoint = document.getElementById(name);
	while (Elements.length)
		insertPoint.parentNode.insertBefore(Elements.shift(),insertPoint)
}

function isInWaitingRoom(obj)
{
	while(obj.nodeName != 'BODY')
	{
		obj=obj.parentNode;
		if (obj.id == 'waitingRoom')
			return true;
	}
	return false;
}


function getAllFormFields(node)
{
	var allFormFields = new Array;
	var x = node.getElementsByTagName('input');
	for (var i=0;i<x.length;i++)
		allFormFields.push(x[i]);
	var y = node.getElementsByTagName('option');
	for (var i=0;i<y.length;i++)
		allFormFields.push(y[i]);
	return allFormFields;
}

// push and shift for IE5

function Array_push() {
	var A_p = 0
	for (A_p = 0; A_p < arguments.length; A_p++) {
		this[this.length] = arguments[A_p]
	}
	return this.length
}

if (typeof Array.prototype.push == "undefined") {
	Array.prototype.push = Array_push
}

function Array_shift() {
	var A_s = 0
	var response = this[0]
	for (A_s = 0; A_s < this.length-1; A_s++) {
		this[A_s] = this[A_s + 1]
	}
	this.length--
	return response
}

if (typeof Array.prototype.shift == "undefined") {
	Array.prototype.shift = Array_shift
}
