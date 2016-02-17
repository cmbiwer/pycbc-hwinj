#! /bin/bash

RUN_DIR=test2/test2

cat ${RUN_DIR}/check_exc/*.txt > ${RUN_DIR}/check_exc/H1L1-All.txt

cat ${RUN_DIR}/check_bitmask/*.txt > ${RUN_DIR}/check_bitmask/H1L1-All.txt

pycbc_convert_segment_csv --segment-files ${RUN_DIR}/check_segdb/*.xml.gz --output-file ${RUN_DIR}/check_segdb/H1L1-ALL.txt
