#! /bin/bash

cat test/check_exc/*.txt > test/check_exc/H1L1-All.txt

cat test/check_odc/*.txt > test/check_odc/H1L1-All.txt

python pycbc_convert_segment_csv --segment-files test/check_segdb/*.xml.gz --output-file test/check_segdb/H1L1-ALL.txt
