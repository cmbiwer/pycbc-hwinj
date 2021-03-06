""" Module that contains the class for organzing hardware injections.
"""

from glue import segments

class HardwareInjection(object):
    """ Class that represents a hardware injection from a single IFO.
    """

    def __init__(self, ifo):

        # set a string to idenity IFO
        self.ifo = ifo

        # a dict that holds all excitation segments
        self.exc_dict = segments.segmentlistdict()

        # a dict that holds all segments from the segdb
        self.seg_dict = segments.segmentlistdict()

        # a dict that holds all segments from bitmasked channels
        self.bitmask_dict = segments.segmentlistdict()

        # GraceDB information about hardware injection
        self.gracedb_id = []
        self.gracedb_time = []

        # schedule information about hardware injection
        self.schedule_time = None
        self.schedule_type = None
        self.schedule_scale_factor = None
        self.schedule_prefix = None

    def __repr__(self):
        return " ".join(map(str, [self.ifo, self.gracedb_id, self.gracedb_time,
                        self.exc_dict, self.seg_dict, self.bitmask_dict,
                        self.schedule_entry]))

    @property
    def schedule_entry(self):
        """ Returns line from schedule file.
        """

        return " ".join(map(str, [self.schedule_time, self.schedule_type,
                                  self.schedule_scale_factor, self.schedule_prefix]))

    def inj_seg(self, exclude_coinc_flags=None):
        """ Returns a segmentlist that is the union of all excitation,
        segdb and bitmasked channels.
        """

        if exclude_coinc_flags is None:
            exclude_coinc_flags = []

        tmp_list = segments.segmentlist([])
        for key in self.exc_dict.keys():
            if key[3:] not in exclude_coinc_flags:
                tmp_list.extend(self.exc_dict[key])
        for key in self.seg_dict.keys():
            if key[3:] not in exclude_coinc_flags:
                tmp_list.extend(self.seg_dict[key])
        for key in self.bitmask_dict.keys():
            if key[3:] not in exclude_coinc_flags:
                tmp_list.extend(self.bitmask_dict[key])
        if self.schedule_time:
            seg = segments.segment(self.schedule_time, self.schedule_time + 1)
            seg_list = segments.segmentlist([seg])
            tmp_list.extend(seg_list)
        for time in self.gracedb_time:
            seg = segments.segment(time, time + 1)
            seg_list = segments.segmentlist([seg])
            tmp_list.extend(seg_list)
        return tmp_list

    def check_single_excitation(self):
        """ Logical check that there was only one excitation at the time.
        """

        if len(self.exc_dict.keys()) != 1:
            return False
        for key in self.exc_dict.keys():
            if len(self.exc_dict[key]) != 1:
                return False
        return True

    # a dict that defines all checks for HardwareInjection
    check_dict = {
        "Single excitation recorded" : check_single_excitation,
    }



