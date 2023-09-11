--
-- Console support for premake.
-- Copyright Blizzard Entertainment, Inc
--

if not premake.modules.consoles then
	require('vstudio')
	premake.modules.consoles = {}

	local p = premake
	local vc2010 = p.vstudio.vc2010

	vc2010.elements.mgcCompile = function(cfg)
		return {
		}
	end

	function vc2010.mgcCompile(cfg)
		if p.config.hasFile(cfg, path.ismgcfile) then
			local contents = p.capture(function ()
				p.push('<MGCCompile>')
				p.outln(contents)
				p.pop('</MGCCompile>')
			end)
		end
	end

	vc2010.categories.MGCCompile = {
		name       = "MGCCompile",
		extensions = { ".mgc", ".Config" },
		priority   = 14,

		emitFiles = function(prj, group)
			local fileCfgFunc = {
				vc2010.excludedFromBuild
			}

			vc2010.emitFiles(prj, group, "MGCCompile", nil, fileCfgFunc)
		end,

		emitFilter = function(prj, group)
			vc2010.filterGroup(prj, group, "MGCCompile")
		end
	}

	-- xbox
	include 'desktop.lua'
	include 'scarlett.lua'

	-- playstation
	include 'psp.lua'
end
