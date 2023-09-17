-- PlayStation Portable support.

--
-- Non-overrides
--

local p = premake
local config = p.config

p.MIPS    = "mips"
p.PSP     = "psp"

p.api.addAllowed("architecture", p.MIPS)
p.api.addAllowed("system", p.PSP)

os.systemTags[p.PSP] = { "psp", "console" }

local osoption = p.option.get("os")
if osoption ~= nil then
    table.insert(osoption.allowed, { p.PSP,  "PlayStation Portable" })
end

filter { "system:psp" }
    architecture "mips"

filter { "system:psp", "kind:ConsoleApp or WindowedApp" }
    targetextension ".elf"

filter { "system:psp", "kind:StaticLib" }
    targetprefix "lib"
    targetextension ".a"

filter { "system:psp", "kind:SharedLib" }
    targetprefix "lib"
    targetextension ".so"

filter {}

-- PSP-specific Premake filter settings
premake.psp = {}
premake.psp.PSPSDK = os.getenv("PSPSDK") or (os.getenv("PSPDEV") or "") .. "/psp/sdk" or "$PSPSDK"
premake.psp.CC = "psp-gcc"
premake.psp.CXX = "psp-g++"
premake.psp.AS = "psp-gcc"
premake.psp.LD = "psp-gcc"
premake.psp.AR = "psp-gcc-ar"
premake.psp.RANLIB = "psp-gcc-ranlib"
premake.psp.STRIP = "psp-strip"
premake.psp.MKSFO = "mksfoex"
premake.psp.PACK_PBP = "pack-pbp"
premake.psp.FIXUP = "psp-fixup-imports"
premake.psp.ENC = "PrxEncrypter"

p.tools.psp = p.tools.gcc

p.tools.psp.tools = {
	cc = p.psp.CC,
	cxx = p.psp.CXX,
	ar = p.psp.AR,
	rc = "echo"
}
p.tools.psp.shared.architecture = {
    mips = "-no-pie -fpermissive"
}

-- Include PSPSDK includes and libraries
premake.psp.INCDIR = { ".", premake.psp.PSPSDK .. "/include" }
premake.psp.LIBDIR = { ".", premake.psp.PSPSDK .. "/lib" }

-- PSP-specific compiler flags
premake.psp.CFLAGS = { "-G0" }
premake.psp.CXXFLAGS = { }
premake.psp.ASFLAGS = { }

-- PSP Firmware version
premake.psp.PSP_FW_VERSION = "150"

-- Expand memory settings
premake.psp.EXPAND_MEMORY = "0"

-- PSP_LARGE_MEMORY settings
premake.psp.PSP_LARGE_MEMORY = "0"

-- PSP_LARGE_MEMORY
premake.psp.PSP_LARGE_MEMORY = "1"

-- LDFLAGS
premake.psp.LDFLAGS = { "-Wl,-zmax-page-size=128" }

-- PSP Kernel libraries
premake.psp.USE_KERNEL_LIBS = "1"

filter { "system:psp" }
    defines {
        "_PSP_FW_VERSION=" .. premake.psp.PSP_FW_VERSION
    }
    includedirs {
        premake.psp.PSPSDK .. "/include",
    }
    libdirs {
        premake.psp.PSPSDK .. "/lib",
    }
    links(premake.psp.LIBS)

filter { "system:psp" }
    buildoptions(premake.psp.CFLAGS)
    pic "Off"
    toolset "psp"

    linkoptions(premake.psp.LDFLAGS)
    links {
        "pspsdk"
    }

-- PSP-specific build settings
filter { "system:psp", "kind:ConsoleApp or WindowedApp" }
    targetextension ".elf"

filter { "system:psp", "kind:StaticLib" }
    targetprefix "lib"
    targetextension ".a"

filter { "system:psp", "kind:SharedLib" }
    targetprefix "lib"
    targetextension ".so"
