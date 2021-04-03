-- [BEGIN]  
local info = gg.getTargetInfo()

--info = nil
gg.alert("Script by Slice Cast")
gg.setVisible(true)
LuaLibraryTool = -1
function HOME()
MENU = gg.choice({
	    "Try Rent Guns", --choice
        "Quit" --EndScript
}, nil, "Script Features:")
if MENU == nil then
  else
   if MENU == 1 then --choice
      MENU1()
     end
    if MENU == 2 then --EndScript
      LOBBY()
     end
   end
  LuaLibraryTool = -1
end

-- [LIB]
local memFrom, memTo, lib, num, lim, results, src, ok = 0, -1, nil, 0, 32, {}, nil, false
function name(n)
	if lib ~= n then
		lib = n
		--print("\nPatch library "..lib..":\n")
		local ranges = gg.getRangesList(lib)
		if #ranges == 0 then
			print("Error: "..lib.." are not found!")
			os.exit()
		else
			memFrom = ranges[1].start
			memTo = ranges[#ranges]["end"]
		end
	end
end
function hex2tbl(hex)
	local ret = {}
	hex:gsub("%S%S", function (ch)
		ret[#ret + 1] = ch
		return ""
	end)
	return ret
end
function original(orig)
	local tbl = hex2tbl(orig)
	gg.clearResults()
	local len = #tbl
	if len == 0 then return end
	local used = len
	if len > lim then used = lim end
	local s = ''
	for i = 1, used do
		if i ~= 1 then s = s..";" end
		local v = tbl[i]
		if v == "??" or v == "**" then v = "0~~0" end		
		s = s..v.."h"
	end
	s = s.."::"..used
	gg.searchNumber(s, gg.TYPE_BYTE, false, gg.SIGN_EQUAL, memFrom, memTo)
	
	if len > used then
		for i = used + 1, len do
			local v = tbl[i]
			if v == "??" or v == "**" then
				v = 256
			else
				v = ("0x"..v) + 0
				if v > 127 then v = v - 256 end
			end
			tbl[i] = v
		end
	end
	
	local found = gg.getResultCount();
	
	results = {}
	local count = 0
	
	local checked = 0
	while true do
		if checked >= found then
			break
		end
		local all = gg.getResults(100000)
		local total = #all
		local start = checked
		if checked + used > total then
			break
		end
			
		while start < total do		
			local good = true
			local offset = all[1 + start].address - 1
			if used < len then			
				local get = {}
				for i = lim + 1, len do
					get[i - lim] = {address = offset + i, flags = gg.TYPE_BYTE, value = 0}
				end
				get = gg.getValues(get)
				
				for i = lim + 1, len do
					local ch = tbl[i]
					if ch ~= 256 and get[i - lim].value ~= ch then
						good = false
						break
					end
				end
			end
			if good then
				count = count + 1
				results[count] = offset
				checked = checked + used
			else
				local del = {}
				for i = 1, used do
					del[i] = all[i + start]
				end
				gg.removeResults(del)
			end
			start = start + used
		end
	end
	gg.clearResults()
end
function replaced(repl)
	num = num + 1
	local msg = "\nPattern N"..num..":"
	if #results == 0 then
		print(msg.." Not found.")
		return
	end
	print(msg)
	local tbl = hex2tbl(repl)
	
	if src ~= nil then
		local source = hex2tbl(src)
		for i, v in ipairs(tbl) do
			if v ~= "??" and v ~= "**" and v == source[i] then tbl[i] = "**" end
		end
		src = nil
	end
	
	local cnt = #tbl
	local set = {}
	local s = 0
	for _, addr in ipairs(results) do
		--print("\tOffset: "..string.format("%x", addr + 1).."\n")		
		for i, v in ipairs(tbl) do
			if v ~= "??" and v ~= "**" then
				s = s + 1
				set[s] = {
					["address"] = addr + i, 
					["value"] = v.."h",
					["flags"] = gg.TYPE_BYTE,
				}
			end
		end		
	end
	if s ~= 0 then gg.setValues(set) end
	ok = true
end
gg.setRanges(gg.REGION_CODE_APP | gg.REGION_C_DATA) -- | gg.REGION_C_BSS

function MENU1()
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
gg.alert("Mod Enabled!")
--gg.alert("Wait 30 Seconds to buy a Weapon!!!")
end
-- 
function LOBBY() --End Script
gg.alert("Thanks for using this Script! ~ Slice Cast")
gg.alert("Discord: Slice")
print("Created By Slice Cast")
gg.skipRestoreState()
  gg.setVisible(true)
  os.exit()
end
while true do
  if gg.isVisible(true) then
    LuaLibraryTool = 1
    gg.setVisible(false)
  end
  if LuaLibraryTool == 1 then
    HOME()
  end
end
