#! /bin/bash

START_TIME=1136419217
END_TIME=$((START_TIME + 604800))

OUTPUT_DIR=/home/cbiwer/public_html/hwinjlog_test
OUTPUT_HTML_FILE=${OUTPUT_DIR}/tmp.html
OUTPUT_CSV_FILE=${OUTPUT_DIR}/tmp.txt

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

SEGMENT_FILE=test/test/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=test/test/check_exc/H1L1-All.txt
BITMASK_FILE=test/test/check_bitmask/H1L1-All.txt
GRACEDB_FILE=`ls test/test/check_gracedb/*-GRACEDB-*-*.txt`
SCHEDULE_FILE=`ls test/test/check_schedule/*-SCHEDULE-*-*.txt`
CONFIG_FILE=${OUTPUT_DIR}/config.ini

cp test/test/test_parsed.ini ${CONFIG_FILE}

pycbc_make_hwinj_table --start-time ${START_TIME} --end-time ${END_TIME} \
    --segment-file ${SEGMENT_FILE} \
    --excitation-file ${EXCITATION_FILE} \
    --bitmask-file ${BITMASK_FILE} \
    --gracedb-file ${GRACEDB_FILE} \
    --schedule-file ${SCHEDULE_FILE} \
    --config-file ${CONFIG_FILE} \
    --output-html-file ${OUTPUT_HTML_FILE} \
    --output-csv-file ${OUTPUT_CSV_FILE}

