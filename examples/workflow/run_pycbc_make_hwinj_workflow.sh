#! /bin/bash

# IFO to analyze (eg. "H1" or "L1")
#IFO=$1

# configuration files
#CONFIG_FILE="${PWD}/config_main.ini ${PWD}/config_${IFO,,}.ini"

CONFIG_FILE="${PWD}/config_main.ini ${PWD}/config_h1.ini ${PWD}/config_l1.ini"

# analysis time from reference time equal to 1 September 2015
WEEK_NUM=1
START_TIME=$((1125100817 + ${WEEK_NUM}*604800))
END_TIME=$((START_TIME + 604800))

# analysis time for test hardware injection
#START_TIME=1128672300
#END_TIME=1128672700

# workflow name
WORKFLOW_NAME="hwinj_${WEEK_NUM}_${START_TIME}_${END_TIME}"

# schedule file
#svn co https://daqsvn.ligo-la.caltech.edu/svn/injection/hwinj/Details/tinj/
TINJ_SCHEDULE_PATH=${PWD}/tinj/schedule

# path to final output directory
RESULTS_DIR=${HOME}/public_html/hwinj_log/o1/${WORKFLOW_NAME}

# change into run dir
mkdir -p ${WORKFLOW_NAME}
cd ${WORKFLOW_NAME}

# run workflow generator
pycbc_make_hwinj_workflow --name ${WORKFLOW_NAME} \
    --config-file ${CONFIG_FILE} \
    --config-overrides workflow:start-time:${START_TIME} \
        workflow:end-time:${END_TIME} \
        workflow-ifos:H1 workflow-ifos:L1 \
        workflow-schedule:schedule-path:${TINJ_SCHEDULE_PATH} \
        workflow-results:results-dir:${RESULTS_DIR} &> ${WORKFLOW_NAME}.txt

# limit workflow to only 16 jobs
export _CONDOR_DAGMAN_MAX_JOBS_SUBMITTED=16

# get rid of grid proxy because it lives in /tmp/ and nodes cannot see that
unset X509_USER_PROXY

# plan and submit the workflow
cd ${WORKFLOW_NAME}
pycbc_submit_dax --no-create-proxy \
    --accounting-group ligo.dev.o1.detchar.explore.test \
    --dax ${WORKFLOW_NAME}.dax
