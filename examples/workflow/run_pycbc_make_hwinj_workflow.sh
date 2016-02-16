#! /bin/bash

WORKFLOW_NAME=test2
CONFIG_FILE=${PWD}/config_h1.ini

IFO1=H1
#IFO2=L1
#START_TIME=1136419217
#END_TIME=$((START_TIME + 604800))
START_TIME=1128672300
END_TIME=1128672700

TINJ_SCHEDULE_PATH=${PWD}/tinj/schedule

#svn co https://daqsvn.ligo-la.caltech.edu/svn/injection/hwinj/Details/tinj/

# change into run dir
mkdir -p ${WORKFLOW_NAME}
cd ${WORKFLOW_NAME}

pycbc_make_hwinj_workflow --name ${WORKFLOW_NAME} \
    --config-file ${CONFIG_FILE} \
    --config-overrides workflow:start-time:${START_TIME} \
        workflow:end-time:${END_TIME} \
        workflow-ifos:${IFO1} \
        workflow-ifos:${IFO2} \
        workflow-schedule:schedule-path:${TINJ_SCHEDULE_PATH}

# limit workflow to only 16 jobs
export _CONDOR_DAGMAN_MAX_JOBS_SUBMITTED=16

# plan and submit the workflow
cd ${WORKFLOW_NAME}
#pycbc_submit_dax --accounting-group ligo.dev.o1.detchar.explore.test --dax ${WORKFLOW_NAME}.dax
