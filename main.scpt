set numbers_key_codes to {29, 18, 19, 20, 21, 23, 22, 26, 28, 25}

set input to the clipboard

if (input is missing value) then
	error number 0
end if

tell application "System Events"
	set activeApp to name of first application process whose frontmost is true
end tell

if (length of input is greater than 250) then
	set msg to "Pasting " & length of input & " characters into " & activeApp & "."
	tell application activeApp
		display alert msg message "Are you sure?" buttons {"Yes", "No"} default button "Yes" cancel button "No"
	end tell
	set answer to button returned of result
	if (answer = "No") then
		error number -128
	end if
	delay 1
end if

tell application "System Events"
	repeat with char in the characters of input
		if (char ≥ 0 and char ≤ 9) then -- numbers
			key code numbers_key_codes's item (char + 1)
		else if (id of char = 46) then -- this is a .
			key code 47
		else if (id of char = 47) then -- this is a /
			key code 44
		else if (id of char = 45) then -- this is a -
			key code 27
		else -- everything else
			keystroke char
		end if
	end repeat
end tell
