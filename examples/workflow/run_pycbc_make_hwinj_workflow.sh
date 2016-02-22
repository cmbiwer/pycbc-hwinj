#! /bin/bash

# configuration files
CONFIG_FILE="${PWD}/config_main.ini ${PWD}/config_h1.ini ${PWD}/config_l1.ini"

# IFO to analyze
IFO1=H1
IFO2=L1

# analysis time for last week of O1
#START_TIME=1136419217
#END_TIME=$((START_TIME + 604800))

# analysis time for test hardware injection
START_TIME=1128672300
END_TIME=1128672700

# workflow name
WORKFLOW_NAME="hwinj_${START_TIME}_${END_TIME}"

# schedule file
#svn co https://daqsvn.ligo-la.caltech.edu/svn/injection/hwinj/Details/tinj/
TINJ_SCHEDULE_PATH=${PWD}/tinj/schedule

# path to final output directory
RESULTS_DIR=${HOME}/public_html/hwinj_log/${WORKFLOW_NAME}

# change into run dir
mkdir -p ${WORKFLOW_NAME}
cd ${WORKFLOW_NAME}

# run workflow generator
pycbc_make_hwinj_workflow --name ${WORKFLOW_NAME} \
    --config-file ${CONFIG_FILE} \
    --config-overrides workflow:start-time:${START_TIME} \
        workflow:end-time:${END_TIME} \
        workflow-ifos:${IFO1} \
        workflow-ifos:${IFO2} \
        workflow-schedule:schedule-path:${TINJ_SCHEDULE_PATH} \
        workflow-results:results-dir:${RESULTS_DIR}

# limit workflow to only 16 jobs
export _CONDOR_DAGMAN_MAX_JOBS_SUBMITTED=16

# plan and submit the workflow
cd ${WORKFLOW_NAME}
pycbc_submit_dax --accounting-group ligo.dev.o1.detchar.explore.test --dax ${WORKFLOW_NAME}.dax
