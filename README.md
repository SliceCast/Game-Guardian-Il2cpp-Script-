# Game-Guardian-Il2cpp-Script-
This is a game guardian (il2cpp Script) for you guys to use if you want to use this without a mod menu. 

#Requirements
•Dump the game
•Grab the offsets

What to do?
•Drag the il2cpp.so in a hex editor or whatever and go-to the offsets.
•Copy the 8Byte hex value (or more, meaning copy another 8byte which adds up to 16bytes)
Note: copying more bytes means that if the script searches your values and find like 50, 100+ searches, your game may end up modifying the wrong values and crash. So we need to add more bytes and more unt we get 1 or 2 searches.

Example: 
name("libil2cpp.so")
--original("EC E4 AA 03 0C E6 AA 03 00 48 2D E9 0D B0 A0 E1")

--replaced("EC E4 AA 03 0C E6 AA 03 00 00 A0 E3 1E FF 2E E1")

--original("94 65 CD 03 94 85 C9 03 30 48 2D E9 08 B0 8D E2")

--replaced("94 65 CD 03 94 85 C9 03 01 00 A0 E3 1E FF 2F E1")

--original("DC BD CD 03 C0 90 CE 03 70 4C 2D E9 10 B0 8D E2")

--replaced("DC BD CD 03 C0 90 CE 03 62 00 E0 E3 1E FF 2F E1")

original("8C 4D CF 03 B0 12 CB 03 30 48 2D E9 08 B0 8D E2")

replaced("8C 4D CF 03 B0 12 CB 03 01 00 A0 E3 1E FF 2F E1")

--original("A4 FD C9 03 CC 3B CE 03 70 4C 2D E9 10 B0 8D E2")

--replaced("A4 FD C9 03 CC 3B CE 03 00 F0 20 E3 1E FF 2F E1")

--original("EC 39 CE 03 BC 39 CE 03 30 48 2D E9 08 B0 8D E2")

--replaced("EC 39 CE 03 BC 39 CE 03 00 F0 20 E3 1E FF 2F E1")


Note: Some of these hex values are backwards aka reversed to get a more precise search value.

Credits to: SliceCast & Pharaoh
