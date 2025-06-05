# ../../bin/${EPICS_HOST_ARCH}/URModule st.cmd
< envPaths

dbLoadDatabase("../../dbd/iocURModuleLinux.dbd")
iocURModuleLinux_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("IOCSH_PS1", "$(IOC)>")
epicsEnvSet("PREFIX", "URModule:")
epicsEnvSet("LUA_SCRIPT_PATH", "lua/")

# < autosave.iocsh

< ur_module.iocsh

###############################################################################
iocInit
###############################################################################

# print the time our boot was finished
date
