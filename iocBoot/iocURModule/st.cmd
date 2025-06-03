# ../../bin/${EPICS_HOST_ARCH}/URModule st.cmd
< envPaths

dbLoadDatabase("../../dbd/iocURModuleLinux.dbd")
iocURModuleLinux_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("IOCSH_PS1", "$(IOC)>")
epicsEnvSet("PREFIX", "URModule:")

# Instantiate the client with a name
AsynHttpClientConfig("client1")

# Example: Control robot arm with REST API
iocshLoad("ur_module.iocsh", "PORT=client1")

###############################################################################
iocInit
###############################################################################

# print the time our boot was finished
date
