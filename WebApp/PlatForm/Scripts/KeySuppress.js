/*==================================================================================================================================================        
File Header Comments:       
Copyright (C) 2007-2012 Attune Technologies, Adyar, Chennai          
====================================================================================================================================================          
Purpose: To handle specific Key strokes (F5, Backspace, Esc) and disable their normal behaviour so that pressing of these keys, even by accident
         doesn't cause any loss of data for the end-users.
		 This header file must be always used after adding "jquery.min.js" (located in the Scripts folder); without which the document ("$") will not
		 get recognized.
Author: Vijayaraghavan TV
Date Created: 10-Oct-2012     
====================================================================================================================================================          
File Change History (to be updated everytime this file is modified)          
        
Date:         
Dev Name:         
Issue ID:         
Fix Details: 
==================================================================================================================================================*/        
var KEYCODE_F5 = 116;
var KEYCODE_ESC = 27;
var KEYCODE_BACKSPACE = 8;

$(document).keydown(SuppressKeyStrokes);

function SuppressKeyStrokes(e) {
    if ((e.keyCode == KEYCODE_BACKSPACE && e.target.type != "text" && e.target.type != "textarea" && e.target.type != "password" && e.target.tagName != "DIV") || (e.keyCode == KEYCODE_BACKSPACE && e.target.type == "textarea" && e.target.readOnly == true)) {

	// cancel backspace navigation 
	e.preventDefault(); 
	e.stopImmediatePropagation(); 
	return false; 
	} 

	if (e.keyCode == KEYCODE_F5) {
		e.preventDefault(); 
		e.stopImmediatePropagation(); 
		return false; 
	} 

	if (e.keyCode == KEYCODE_ESC) {
		e.preventDefault(); 
		e.stopImmediatePropagation(); 
		return false; 
	} 
};