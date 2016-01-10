#! /bin/bash

START_TIME=1128672300
END_TIME=1128672700

OUTPUT_DIR=/home/cbiwer/public_html/hwinjlog_test
OUTPUT_FILE=${OUTPUT_DIR}/tmp.html

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

SEGMENT_FILE=test/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=test/check_exc/H1L1-All.txt
BITMASK_FILE=test/check_bitmask/H1L1-All.txt
GRACEDB_FILE=test/check_gracedb/H1L1-GRACEDB-1128672300-400.txt
SCHEDULE_FILE=test/check_schedule/H1L1-SCHEDULE-1128672300-400.txt

python pycbc_make_hwinj_table --start-time ${START_TIME} --end-time ${END_TIME} \
    --segment-file ${SEGMENT_FILE} \
    --excitation-file ${EXCITATION_FILE} \
    --bitmask-file ${BITMASK_FILE} \
    --gracedb-file ${GRACEDB_FILE} \
    --schedule-file ${SCHEDULE_FILE} \
    --output-file ${OUTPUT_FILE}

cp -r static ${OUTPUT_DIR}
