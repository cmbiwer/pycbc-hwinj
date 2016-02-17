#! /bin/bash

START_TIME=1136419217
END_TIME=$((START_TIME + 604800))
START_TIME=1128672300
END_TIME=1128672700

OUTPUT_DIR=/home/cbiwer/public_html/hwinjlog_test
OUTPUT_HTML_FILE=${OUTPUT_DIR}/tmp.html
OUTPUT_CSV_FILE=${OUTPUT_DIR}/tmp.txt

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

RUN_DIR=test2/test2
SEGMENT_FILE=${RUN_DIR}/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=${RUN_DIR}/check_exc/H1L1-All.txt
BITMASK_FILE=${RUN_DIR}/check_bitmask/H1L1-All.txt
GRACEDB_FILE=`ls ${RUN_DIR}/check_gracedb/*-GRACEDB-*-*.txt`
SCHEDULE_FILE=`ls ${RUN_DIR}/check_schedule/*-SCHEDULE-*-*.txt`
CONFIG_FILE=${OUTPUT_DIR}/config.ini

cp ${RUN_DIR}/test2_parsed.ini ${CONFIG_FILE}

pycbc_make_hwinj_table --start-time ${START_TIME} --end-time ${END_TIME} \
    --segment-file ${SEGMENT_FILE} \
    --excitation-file ${EXCITATION_FILE} \
    --bitmask-file ${BITMASK_FILE} \
    --gracedb-file ${GRACEDB_FILE} \
    --schedule-file ${SCHEDULE_FILE} \
    --config-file ${CONFIG_FILE} \
    --output-html-file ${OUTPUT_HTML_FILE} \
    --output-csv-file ${OUTPUT_CSV_FILE}

