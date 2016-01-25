import os
from glue import segments
from pycbc.frame import datafind_connection
from pycbc import workflow

def frame_paths(frame_type, start_time, end_time, server=None):
    #! FIXME: make this a pull request to use urltype in PyCBC frame module
    site = frame_type[0]
    connection = datafind_connection(server)
    times = connection.find_times(site, frame_type,
                                  gpsstart=start_time,
                                  gpsend=end_time)
    cache = connection.find_frame_urls(site, frame_type, start_time, end_time, urltype="file")
    paths = [entry.path for entry in cache]
    return paths

def get_frame_files(wf, frame_files, ifo, frame_type):

    # see if frame files already in workflow and if not then add them
    tmp_files = frame_files[ifo].find_output_with_tag(frame_type)
    if not tmp_files:
        paths = frame_paths(frame_type, wf.analysis_time[0], wf.analysis_time[1])
        for frame_path in paths:

            # get frame segment from filename
            frame_start_time = int(os.path.basename(frame_path).rstrip(".gwf").split("-")[-2])
            frame_duration = int(os.path.basename(frame_path).rstrip(".gwf").split("-")[-1])
            frame_seg = segments.segment(frame_start_time, frame_start_time + frame_duration)

            # append frame file to list of frame files for this IFO
            frame_file = workflow.File(ifo, "DATAFIND", frame_seg, file_url="file://localhost" + frame_path, tags=[frame_type])
            frame_file.PFN(frame_path, site="local")
            frame_files[ifo].append(frame_file)
            tmp_files.append(frame_file)

    return tmp_files
