(function() {

'use strict';

var se = Application('System Events');
se.includeStandardAdditions = true;
var input = se.theClipboard();

var proc = se.processes.whose({frontmost: true})[0];
var name = proc.name();
var app = Application(name);
app.includeStandardAdditions = true;

console.log("Input length: " + input.length + " characters");

if (input.length > 250) {
	var mainMsg = "Attempting to paste " + input.length + " characters into " + name + "."
	var confirmationMsg = "Are you sure?"
	se.displayDialog(mainMsg, {
		buttons: ["Paste", "Stop"],
		defaultButton: "Paste",
		cancelButton: "Stop",
		withIcon: "caution" } )

	app.activate()
	delay(1)
}

var numbers_key_codes = [29, 18, 19, 20, 21, 23, 22, 26, 28, 25]
var bad_chars      = [".",     "/",   "-",  "*",  "+"];
var bad_char_codes = [47,       44,    27,   28,   24];
var need_shift     = [false, false, false, true, true];

for (var i = 0; i < input.length; i++) {
	var c = input.charAt(i);
	var c_num = parseInt(c);
	var bad_code = bad_chars.indexOf(c);
	if ( c_num >= 0 && c_num <= 9 ) {
		se.keyCode(numbers_key_codes[c_num]);
	} else if ( bad_code != -1 ) {
		if (need_shift[bad_code]) {
			se.keyCode(bad_char_codes[bad_code], { using: 'shift down' });
		} else {
			se.keyCode(bad_char_codes[bad_code]);
		}
	} else {
		se.keystroke(c);
	}
	delay(0.005);
}
return 0;
})();
