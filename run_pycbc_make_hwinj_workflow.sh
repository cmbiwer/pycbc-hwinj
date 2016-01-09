#! /bin/bash

WORKFLOW_NAME=test
CONFIG_FILE=${PWD}/config.ini

IFO1=H1
IFO2=L1
START_TIME=1128672300
END_TIME=1128672700

TINJ_SCHEDULE_PATH=${PWD}/hwinj_svn/tinj/schedule

python pycbc_make_hwinj_workflow --name ${WORKFLOW_NAME} \
    --config-file ${CONFIG_FILE} \
    --config-overrides workflow:start-time:${START_TIME} \
        workflow:end-time:${END_TIME} \
        workflow-ifos:${IFO1} \
        workflow-ifos:${IFO2} \
        workflow-schedule:schedule-path:${TINJ_SCHEDULE_PATH}

# plan and submit the workflow
cd ${WORKFLOW_NAME}
pycbc_submit_dax --accounting-group ligo.dev.o1.detchar.explore.test --dax ${WORKFLOW_NAME}.dax
