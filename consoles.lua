--
-- Console support for premake.
-- Copyright Blizzard Entertainment, Inc
--

if not premake.modules.consoles then
	require('vstudio')
	premake.modules.consoles = {}

	-- xbox
	include 'desktop.lua'
	include 'scarlett.lua'
end
