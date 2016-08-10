import lal
from glue import segments
from glue.ligolw import utils, table, lsctables, ligolw

class ContentHandler(ligolw.LIGOLWContentHandler):
    pass
lsctables.use_in(ContentHandler)

def fromsegmentxml(xml_file, return_dict=False, select_seg_def_id=None):
    """ Read a glue.segments.segmentlist from the file object file
    containing an xml segment table.

    Parameters
    -----------
    xml_file : file object
        file object for segment xml file
    return_dict : boolean, optional (default = False)
        returns a glue.segments.segmentlistdict containing coalesced
        glue.segments.segmentlists keyed by seg_def.name for each entry in the
        contained segment_def_table.
    select_seg_def_id : int, optional (default = None)
        returns a glue.segments.segmentlist object containing only those
        segments matching the given segment_def_id integer

    Returns
    --------
    segs : glue.segments.segmentlist instance
        The segment list contained in the file.
    """

    # load XML with SegmentDefTable and SegmentTable
    xmldoc, digest = utils.load_fileobj(xml_file,
                                        gz=xml_file.name.endswith(".gz"),
                                        contenthandler=ContentHandler)
    seg_def_table = table.get_table(xmldoc,
                                    lsctables.SegmentDefTable.tableName)
    seg_table = table.get_table(xmldoc, lsctables.SegmentTable.tableName)

    if return_dict:
        segs = segments.segmentlistdict()
    else:
        segs = segments.segmentlist()

    seg_id = {}
    for seg_def in seg_def_table:

        # encode ifo, channel name and version
        full_channel_name = ':'.join([str(seg_def.ifos),
                                      str(seg_def.name),
                                      str(seg_def.version)])
        seg_id[int(seg_def.segment_def_id)] = full_channel_name
        if return_dict:
            segs[full_channel_name] = segments.segmentlist()

    for seg in seg_table:
        seg_obj = segments.segment(
                lal.LIGOTimeGPS(seg.start_time, seg.start_time_ns),
                lal.LIGOTimeGPS(seg.end_time, seg.end_time_ns))
        if return_dict:
            segs[seg_id[int(seg.segment_def_id)]].append(seg_obj)
        elif select_seg_def_id is not None:
            if int(seg.segment_def_id) == select_seg_def_id:
                segs.append(seg_obj)
        else:
            segs.append(seg_obj)

    if return_dict:
        for seg_name in seg_id.values():
            segs[seg_name] = segs[seg_name].coalesce()
    else:
        segs = segs.coalesce()

    xmldoc.unlink()

    return segs
