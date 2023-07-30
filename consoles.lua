--
-- Console support for premake.
-- Copyright Blizzard Entertainment, Inc
--

if not premake.modules.consoles then
	require('vstudio')
	premake.modules.consoles = {}

	-- xbox
	include 'xbox.lua'
	include 'durango.lua'
	include 'scarlett.lua'
	include 'desktop.lua'
	include 'xboxone_gdk.lua'
end
