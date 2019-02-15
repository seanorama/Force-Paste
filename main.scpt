set numbers_key_codes to {29, 18, 19, 20, 21, 23, 22, 26, 28, 25}

set input to the clipboard

if (input is not missing value and length of input is less than 250) then
	tell application "System Events"
		repeat with char in the characters of input
			if (char ≥ 0 and char ≤ 9) then -- numbers
				key code numbers_key_codes's item (char + 1)
			else if (id of char = 46) then -- dot
				key code 47
			else if (id of char = 47) then -- this is a /
				key code 44
			else if (id of char = 45) then -- this is a -
				key code 27
			else -- everything else
				keystroke char
			end if
			delay 0.01
		end repeat
	end tell
end if
