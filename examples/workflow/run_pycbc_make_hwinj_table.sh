#! /bin/bash

START_TIME=1128672300
END_TIME=1128672700

OUTPUT_DIR=/home/cbiwer/public_html/hwinjlog_test
OUTPUT_HTML_FILE=${OUTPUT_DIR}/tmp.html
OUTPUT_CSV_FILE=${OUTPUT_DIR}/tmp.txt

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

SEGMENT_FILE=test/test/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=test/test/check_exc/H1L1-All.txt
BITMASK_FILE=test/test/check_bitmask/H1L1-All.txt
GRACEDB_FILE=test/test/check_gracedb/H1L1-GRACEDB-1128672300-400.txt
SCHEDULE_FILE=test/test/check_schedule/H1L1-SCHEDULE-1128672300-400.txt
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

