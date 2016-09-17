#! /bin/bash

# week number
NUM=${1}

# name of workflow
# use naming convention to find workflow name from only week number
WORKFLOW_NAME=`ls -d hwinj_${NUM}_*`
GPS_START_TIME=${WORKFLOW_NAME:8:10}
GPS_END_TIME=${WORKFLOW_NAME:19:10}

# directories
RUN_DIR=${WORKFLOW_NAME}/${WORKFLOW_NAME}
HTML_DIR=${HOME}/public_html/hwinj_log/o1/${WORKFLOW_NAME}

# make HTML table
mkdir -p ${HTML_DIR}
python ../../bin/pycbc_make_hwinj_table --start-time ${GPS_START_TIME} --end-time ${GPS_END_TIME} \
    --excitation-file  ${RUN_DIR}/check_exc/H1L1-CAT_FRAME_DATA_EXC-${GPS_START_TIME}-604800.txt \
    --bitmask-file  ${RUN_DIR}/check_bitmask/H1L1-CAT_FRAME_DATA_BITMASK-${GPS_START_TIME}-604800.txt \
    --gracedb-file  ${RUN_DIR}/check_gracedb/H1L1-GRACEDB-${GPS_START_TIME}-604800.txt \
    --segment-file  ${RUN_DIR}/check_segdb/H1L1-CAT_SEGDB_DATA-${GPS_START_TIME}-604800.txt \
    --schedule-file  ${RUN_DIR}/check_schedule/H1L1-SCHEDULE-${GPS_START_TIME}-604800.txt \
    --config-file  ${HTML_DIR}/config.ini \
    --output-html-file ${HTML_DIR}/H1L1-MAKE_TABLE-${GPS_START_TIME}-604800.html  \
    --output-csv-file ${HTML_DIR}/H1L1-MAKE_TABLE-${GPS_START_TIME}-604800.csv \
    --output-static-dir ${HTML_DIR}/static/ \
    --exclude-coinc-flags DMT-ANALYSIS_READY:1 INJ_HARDWARE_INPUT_ON INJ_HARDWARE_OUTPUT_ON INJ_TRANSIENT_OUTPUT_ON INJ_TRANSIENT_INPUT_ON PINJX_TRANSIENT_OUTPUT_ON PINJX_HARDWARE_OUTPUT_ON PINJX_HARDWARE_INPUT_ON PINJX_TRANSIENT_INPUT_ON PINJX_TRANSIENT_OUTPUT_ON

