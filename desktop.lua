--
-- Gaming Desktop support for Visual Studio backend.
-- Copyright Blizzard Entertainment, Inc
--

--
-- Non-overrides
--

local p = premake
local vstudio = p.vstudio
local vc2010 = p.vstudio.vc2010
local config = p.config

p.GAMING_DESKTOP     = "gaming_desktop"

if vstudio.vs2010_architectures ~= nil then
	vstudio.vs2010_architectures.gaming_desktop = "Gaming.Desktop.x64"
	p.api.addAllowed("system", p.GAMING_DESKTOP)

	os.systemTags[p.GAMING_DESKTOP] = { "gaming_desktop", "gdk" }

	local osoption = p.option.get("os")
	if osoption ~= nil then
		table.insert(osoption.allowed, { p.GAMING_DESKTOP,  "Gaming Desktop" })
	end
end


filter { "system:gaming_desktop" }
	architecture "x86_64"

filter { "system:gaming_desktop", "kind:ConsoleApp or WindowedApp" }
	targetextension ".exe"

filter { "system:gaming_desktop", "kind:StaticLib" }
	targetprefix ""
	targetextension ".lib"

filter { "system:gaming_desktop", "kind:SharedLib" }
    targetprefix ""
    targetextension ".dll"

filter {}
