
def table_row_keys(exc_keys, seg_keys, bitmask_keys, check_keys):
    """ Returns a list of column labels.
    """

    cols = ["IFO", "GraceDB IDs", "GraceDB Times", "All checks passed"]
    for key in check_keys:
        cols.append(key)
    for key in exc_keys:
        cols.append("Excitations from "+key)
    for key in seg_keys:
        cols.append("Segments from "+key)
    for key in bitmask_keys:
        cols.append("Bitmask segments from "+key)
    cols.append("Schedule")
    return cols

def table_row_values(hwinj, exc_keys, seg_keys, bitmask_keys, check_keys):
    """ Returns a list of column values for a HardwareInjection.
    """

    cols = [hwinj.ifo] 
    cols.append(" ".join([str(id) for id in hwinj.gracedb_id]))
    cols.append(" ".join([str(time) for time in hwinj.gracedb_time]))
    all_checks_str = ""
    for key in check_keys:
        if not hwinj.check_dict[key](hwinj):
            all_checks_str = ""
            break
        all_checks_str = "&#10004"
    cols.append(all_checks_str)
    for key in check_keys:
        if hwinj.check_dict[key](hwinj):
            cols.append("&#10004")
        else:
            cols.append("")
    for key in exc_keys:
        if key in hwinj.exc_dict.keys():
            seg_list = hwinj.exc_dict[key]
            seg_str = ""
            for seg in seg_list:
                seg_str += "-".join(map(str, seg))
                if seg != seg_list[-1]:
                    seg_str += " "
        else:
            seg_str = "None"
        cols.append(seg_str)
    for key in seg_keys:
        if key in hwinj.seg_dict.keys():
            seg_list = hwinj.seg_dict[key]
            seg_str = ""
            for seg in seg_list:
                seg_str += "-".join(map(str, seg))
                if seg != seg_list[-1]:
                     seg_str += " "
        else:
            seg_str = "None"
        cols.append(seg_str)
    for key in bitmask_keys:
        if key in hwinj.bitmask_dict.keys():
            seg_list = hwinj.bitmask_dict[key]
            seg_str = ""
            for seg in seg_list:
                seg_str += "-".join(map(str, seg))
                if seg != seg_list[-1]:
                    seg_str += " "
        else:
            seg_str = "None"
        cols.append(seg_str)
    cols.append(hwinj.schedule_entry)
    return cols

