#! /bin/bash

START_TIME=1128672300
END_TIME=1128672700

OUTPUT_DIR=/home/cbiwer/public_html
OUTPUT_FILE=${OUTPUT_DIR}/tmp.html

SEGMENT_FILE=test/check_segdb/H1L1-ALL.txt
EXCITATION_FILE=test/check_exc/H1L1-All.txt
ODC_FILE=test/check_odc/H1L1-All.txt
STATE_VECTOR_FILE=test/check_vector/H1L1-All.txt
GRACEDB_FILE=test/check_gracedb/H1L1-GRACEDB-1128672300-400.txt
SCHEDULE_FILE=test/check_schedule/H1L1-SCHEDULE-1128672300-400.txt

python pycbc_make_hwinj_table --start-time ${START_TIME} --end-time ${END_TIME} \
    --segment-file ${SEGMENT_FILE} \
    --excitation-file ${EXCITATION_FILE} \
    --odc-file ${ODC_FILE} \
    --state-vector-file ${STATE_VECTOR_FILE} \
    --gracedb-file ${GRACEDB_FILE} \
    --schedule-file ${SCHEDULE_FILE} \
    --output-file ${OUTPUT_FILE}

cp -r static ${OUTPUT_DIR}
