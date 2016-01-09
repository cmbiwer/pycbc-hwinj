#! /bin/bash

START_TIME=1128672300
END_TIME=1128672700

OUTPUT_FILE=/home/cbiwer/public_html/tmp.html

SEGMENT_FILE=test/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=test/check_exc/H1L1-All.txt
GRACEDB_FILE=test/check_gracedb/H1L1-GRACEDB-1128672300-400.txt
SCHEDULE_FILE=test/check_schedule/H1L1-SCHEDULE-1128672300-400.txt

python pycbc_make_hwinj_table --start-time ${START_TIME} --end-time ${END_TIME} \
    --segment-file ${SEGMENT_FILE} \
    --excitation-file ${EXCITATION_FILE} \
    --gracedb-file ${GRACEDB_FILE} \
    --schedule-file ${SCHEDULE_FILE} \
    --output-file ${OUTPUT_FILE}
