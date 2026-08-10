--
-- Generated from Hubstaff.config.lua.in
--


local X86_INSTALL_SIZE = 0
local X86_64_INSTALL_SIZE = 173952776
local DATA_INSTALL_SIZE = 900595

local _ = MojoSetup.translate
local APPNAME = "Hubstaff"

-- If we decide you have a 32-bit machine, we don't give you the install
--  choice. If we think you're on 64-bit, we'll ask which you want, defaulting
--  to 64.
local is32bit =
        MojoSetup.cmdline("32bit") or
        MojoSetup.info.machine == "x86" or
        MojoSetup.info.machine == "i386" or
        MojoSetup.info.machine == "i586" or
        MojoSetup.info.machine == "i686"

local has64bit = 
        X86_64_INSTALL_SIZE > 0

local has32bit = 
        X86_INSTALL_SIZE > 0

Setup.Package
{
    vendor = "Netsoft Holdings, LLC.",
    id = "Hubstaff",
    description = APPNAME,
    version = "1.9.2",
    splash = "splash.png",
    splashpos = "top",
    superuser = false,
    write_manifest = true,
    support_uninstall = true,
    precheck = function(package)
        if( MojoSetup.info.euid == 0 ) then
            return _("$APPNAME does not support being installed as root")
        end
        if( is32bit and not has32bit ) then
            return _("This installer doesn't support your architecture.\nIt only contains x86_64 (Intel 64bit) executables.")
        end
    end,
    preinstall = function(install)
--        uninstall prior version using helper script
        if( not MojoSetup.platform.exists( MojoSetup.destination, "uninstall-Hubstaff.sh" ) ) then
            -- no previous install, do nothing
        elseif( not (0 == MojoSetup.platform.runscript( "meta/silentuninstall.sh", false, MojoSetup.destination .. "/uninstall-Hubstaff.sh" )) ) then
            return _("Hubstaff could not clean up prior install")
        end
    end,
    postinstall = function(install)
        if( MojoSetup.info.euid == 0 ) then
            -- dont run as root, global install?
        elseif( not install.desktopmenuitems[1].disabled ) then
              install.postexec = install.desktopmenuitems[1].commandline
        elseif( not install.desktopmenuitems[2].disabled ) then
              install.postexec = install.desktopmenuitems[2].commandline
        end
        
        if( install.postexec ~= nil ) then
            install.postexec = string.gsub( install.postexec, '%%0', "$DESTINATION" )
        end
    end,
    preuninstall = function(uninstall)
        -- remove the autostart item
        -- We need to manually remove it because it is not created by the installer, but directly by the app
        MojoSetup.platform.runscript( "meta/xdg-autostart-item", false, "uninstall", "com.hubstaff.client.desktop" )
    end,
    recommended_destinations =
    {
        MojoSetup.info.homedir,
        "/opt"
    },

--    Setup.Eula
--    {
--        description = _("Hubstaff EULA"),
--        source = _("EULA/en.txt")
--    },

    Setup.Readme
    {
        description = _("Included Software"),
        source = "data/NOTICE"
    },

    Setup.Readme
    {
        description = _("Linux Install Notes"),
        source = "data/README.linux"
    },

    Setup.Option
    {
        -- !!! FIXME: All this filter nonsense is because
        -- !!! FIXME:   source = "base:///some_dir_in_basepath/"
        -- !!! FIXME: doesn't work, since it wants a file when drilling
        -- !!! FIXME: for the final archive, not a directory. Fixing this
        -- !!! FIXME: properly is a little awkward, though.

        value = true,
        required = true,
        disabled = false,
        bytes = DATA_INSTALL_SIZE,
        description = APPNAME,

        Setup.OptionGroup
        {
            description = _("CPU Architecture"),
            Setup.Option
            {
                value = is32bit,
                required = is32bit,
                disabled = not has32bit,
                bytes = X86_INSTALL_SIZE,
                description = "x86",
                Setup.File
                {
                    wildcards = "x86/*";
                    filter = function(fn)
                        return string.gsub(fn, "^x86/", "", 1), nil
                    end
                },
                Setup.DesktopMenuItem
                {
                    disabled = false,
                    name = APPNAME,
                    genericname = APPNAME,
                    filename = "netsoft-com.netsoft.hubstaff",
                    tooltip = _(APPNAME),
                    builtin_icon = false,
                    icon = "resources/Hubstaff.png",
                    commandline = "%0/HubstaffClient.bin.x86",
                    commandlinearg = "%%u",
                    mimetype = "x-scheme-handler/hubstaff",
                    workingdir = "%0",
                    category = "Utility;"
                },
            },
            Setup.Option
            {
                value = not is32bit,
                required = false,
                disabled = is32bit or not has64bit,
                bytes = X86_64_INSTALL_SIZE,
                description = "x86_64",
                Setup.File
                {
                    wildcards = "x86_64/*";
                    filter = function(fn)
                        return string.gsub(fn, "^x86_64/", "", 1), nil
                    end
                },
                Setup.DesktopMenuItem
                {
                    disabled = false,
                    name = APPNAME,
                    genericname = APPNAME,
                    filename = "netsoft-com.netsoft.hubstaff",
                    tooltip = _(APPNAME),
                    builtin_icon = false,
                    icon = "resources/Hubstaff.png",
                    commandline = "%0/HubstaffClient.bin.x86_64",
                    commandlinearg = "%%u",
                    mimetype = "x-scheme-handler/hubstaff",
                    workingdir = "%0",
                    category = "Utility;"
                },
            },
        },

        Setup.File
        {
            wildcards = "data/*";
            filter = function(fn)
                return string.gsub(fn, "^data/", "", 1), nil
            end
        },

    }
}

-- end of config.lua ...
