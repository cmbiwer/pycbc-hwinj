# pycbc-hwinj

This is a package for building a high-throughput computing workflow that cross checks the different logs for LIGO hardware injections. It uses Pegasus (via the PyCBC workflow tools) to create and run a workflow.

This workflow has the ability to check the following sources with hardware injection timing data:
  * Channels in the raw frames (eg. the excitation channels)
  * Filterbank switch channels in the raw frames (eg. filterbank on and off switches)
  * ODC channels in the raw frames (eg. the hardware injection ODC channel)
  * Low-latency state vector that is downstream from ODC
  * Segment database that is downstream from ODC
  * Gravitational-Wave Candidate Event Database (GraceDB)

## dependencies

Depends on PyCBC (http://github.com/ligo-cbc/pycbc).

## workflow

The workflow generator is ``pycbc_make_hwinj_workflow``. The workflow generator takes a configuration file that states what logging sources to check. The workflow generator will check the segment database and GraceDB queries.

A few generic executables in the workflow:
  * ``pycbc_check_frame_bitmask`` applies a bitmask to a channel and returns contiguous segments.
  * ``pycbc_check_frame_excitation`` checks for contiguous segments of non-zero values in a channel.
  * ``pycbc_cat_frame_data`` concatenates output files from the two executables above.
  * ``pycbc_cat_segdb_data`` concatenates LIGOLW XML files returned from the segment database.

The HTML summary pages are created with ``pycbc_make_hwinj_table``.

![hardware injection workflow](https://github.com/cmbiwer/pycbc-hwinj/blob/master/docs/static/hwinj_workflow.png "Hardware Injection Workflow")

## how to run example

To run the example change into the example directory:
```
cd examples/workflow
```

Checkout the SVN repository that contains the transient injeciton schedule file with:
```
svn co https://daqsvn.ligo-la.caltech.edu/svn/injection/hwinj/Details/tinj/
```

Create a credential to remotely access the segment database when you run the workflow generator with:
```
ligo-proxy-init albert.einstein
```
Where ``albert.einstein`` is your LIGO.ORG username.

There is a script, ``run_pycbc_make_hwinj_workflow.sh``, that is setup to run the workflow beginning the week of September 1, 2015. It takes one argument that is the number of the week since September 1, 2015. For example to run on the third week since September 1, 2015, do:
```
sh run_pycbc_make_hwinj_workflow.sh 3
```

This will plan and submit the workflow.

Note that if you are doing many I/O operations on raw frame files there will be a significant speed up if you do not checksum all the files each time it is opened.

If you need to rerun a workflow but do not want to rerun all the jobs in the workflow you can give ``pycbc_submit_dax`` the ``--cache-file`` option to use exisiting data.
