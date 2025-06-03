# ../../bin/${EPICS_HOST_ARCH}/URModule st.cmd
< envPaths

dbLoadDatabase("../../dbd/iocURModuleLinux.dbd")
iocURModuleLinux_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("IOCSH_PS1", "$(IOC)>")
epicsEnvSet("PREFIX", "URModule:")

# Instantiate HTTP client and load some requests
AsynHttpClientConfig("client1")
dbLoadTemplate("requests.substitutions", "P=$(PREFIX),PORT=client1")

epicsEnvSet("LUA_SCRIPT_PATH", "lua/")
dbLoadRecords("$(TOP)/URModuleApp/Db/set_movement_params.db", "P=$(PREFIX),R=UR3:,RQ1=Req1:,RQ2=Req2:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/URModuleApp/Db/toggle_gripper.db", "P=$(PREFIX),R=UR3:,RQ1=Req3:,RQ2=Req4:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/URModuleApp/Db/gripper_pick.db", "P=$(PREFIX),R=UR3:,RQ1=Req5:,RQ2=Req6:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/URModuleApp/Db/gripper_place.db", "P=$(PREFIX),R=UR3:,RQ1=Req7:,RQ2=Req8:,HOST=localhost:3030")

###############################################################################
iocInit
###############################################################################

# print the time our boot was finished
date
