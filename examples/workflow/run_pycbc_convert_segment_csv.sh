#! /bin/bash

cat test/test/check_exc/*.txt > test/test/check_exc/H1L1-All.txt

cat test/test/check_bitmask/*.txt > test/test/check_bitmask/H1L1-All.txt

pycbc_convert_segment_csv --segment-files test/test/check_segdb/*.xml.gz --output-file test/test/check_segdb/H1L1-ALL.txt
