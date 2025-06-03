# ../../bin/${EPICS_HOST_ARCH}/URModule st.cmd
< envPaths

dbLoadDatabase("../../dbd/iocURModuleLinux.dbd")
iocURModuleLinux_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("IOCSH_PS1", "$(IOC)>")
epicsEnvSet("PREFIX", "URModule:")
epicsEnvSet("LUA_SCRIPT_PATH", "lua/")

< autosave.iocsh

# Instantiate HTTP client and load some requests
AsynHttpClientConfig("client1")
dbLoadTemplate("requests.substitutions", "P=$(PREFIX),PORT=client1")

# We use the lunajson lua library included with ASYN_HTTP_CLIENT,
# so we must append to the lua package path
epicsEnvSet("LUA_PATH", "$(ASYN_HTTP_CLIENT)/asynHttpClientApp/src/lua/?.lua;$(LUA_PATH=)")

# Load database for each REST node action
# NOTE: only toggle_gripper uses its RQ2 request at the moment
dbLoadRecords("$(TOP)/db/set_movement_params.db", "P=$(PREFIX),R=UR3:,RQ1=Req1:,RQ2=Req2:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/db/toggle_gripper.db", "P=$(PREFIX),R=UR3:,RQ1=Req3:,RQ2=Req4:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/db/gripper_pick.db", "P=$(PREFIX),R=UR3:,RQ1=Req5:,RQ2=Req6:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/db/gripper_place.db", "P=$(PREFIX),R=UR3:,RQ1=Req7:,RQ2=Req8:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/db/pipette_dispense_retrieve.db", "P=$(PREFIX),R=UR3:,RQ1=Req9:,RQ2=Req10:,HOST=localhost:3030")
dbLoadRecords("$(TOP)/db/pipette_pick_move_sample.db", "P=$(PREFIX),R=UR3:,RQ1=Req11:,RQ2=Req12:,HOST=localhost:3030")

###############################################################################
iocInit
###############################################################################

# print the time our boot was finished
date
